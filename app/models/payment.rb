class Payment < ActiveRecord::Base
  belongs_to :member
  belongs_to :privilege
  belongs_to :paymenttype
  belongs_to :payment_method
  belongs_to :person
  validates :amount, :privilege_id, :payment_method_id, :paymenttype_id, :member_id, presence: true
  # validates_presence_of :amount, :privilege_id, :payment_method_id, :paymenttype_id, :member_id
  validates :date_lodged, allow_nil: false, presence: true
  validates :amount, numericality: true

  # validates_associated :member

  validate :payment_type_unique_for_year, unless: proc { |payment| payment.date_lodged.nil? }, if: :renewal_payment?
  validate :payment_final_and_first, unless: proc { |payment| payment.date_lodged.nil? }, if: :final_payment?
  validate :check_unknown_payment_method

  # default_scope { includes(:paymenttype,:privilege,:payment_method)}
  scope :renewal, -> { where('paymenttype_id in (1,4 ) ') }
  scope :current_year, -> { where('date_lodged >= ? ', Time.now.utc.beginning_of_year) }
  # scope :year, -> date_lodged {  where('date_lodged >= ? ', date_lodged )  }
  scope :member, -> { where('member_id = ?', member_id) }
  scope :first_payment, -> (date_lodged) { where('paymenttype_id = ? and date_lodged >= ? ', '4', date_lodged.beginning_of_year) }
  scope :by_year, -> (date_lodged) { where(date_lodged: date_lodged.beginning_of_year..date_lodged) }
  scope :by_date_range, -> (start_date, end_date) { where(date_lodged: start_date..end_date) }
  scope :membership_renewal_payments, -> { where('paymenttype_id in (1,4) ') }
  scope :all_membership_payments, -> { where('paymenttype_id in (1,4,5) ') }
  scope :real_membership_renewals, -> { where('member_class not in (?,?,?,?)', 'X', 'Y', 'E', 'T') }

  scope :year_total, lambda { |start_date, end_date|
    all_membership_payments
      .joins(:privilege, :paymenttype)
      .by_date_range(start_date, end_date)
  }
  scope :members_year_total, lambda { |start_date, end_date|
    membership_renewal_payments
      .joins(:privilege, :paymenttype)
      .by_date_range(start_date, end_date)
  }

  scope :yttypes, lambda { |start_date, end_date|
    Payment
      .year_total(start_date, end_date).
      # select(year(date_lodged))
      select('extract(year from date_lodged) as year, member_class, COUNT(*) as tot,SUM(amount) as money, privileges.name')
      .group('privileges.member_class, privileges.name, year')
  }

  scope :rttypes, lambda { |start_date, end_date|
    Payment
      .members_year_total(start_date, end_date)
      .select('extract(year from date_lodged) ,member_class, COUNT(*) as paytot,SUM(amount) as paysmoney, privileges.name')
      .group('privileges.member_class, privileges.name, year')
  }

  delegate :main_member, to: :member

  def check_unknown_payment_method
    if pay_type == '??'
      errors.add(:pay_type, 'Please select the correct payment method for this payment')
    end
  end

  def final_payment?
    paymenttype_id == 5
  end

  def payment_type_unique_for_year
    # Payment types 1 and 4 must not be duplicated in one year
    if renewal_payment? & !final_payment?
      if num_duplicates > 0
        errors.add(:paymenttype_id, 'Please check the Subscription type, you cannot have two Subscription payments in one year')
      end
    end
  end

  def num_duplicates
    renewals.by_year(date_lodged).count
  end

  def renewals
    if id.nil?
      self.class.where('member_id = ? ', member_id).renewal
    else
      self.class.where('id <> ?  and member_id = ? ', id, member_id).renewal
    end
  end

  def payment_final_and_first
    # Must have a first payment in order to have a final payment.
    if first_payments.count == 0
      errors.add(:paymenttype_id, 'Must have a First payment to have a Final payment')
    end
  end

  def first_payments
    Payment.first_payment(date_lodged).where('member_id = ? ', member_id)
  end

  def self.types
    { 'CS' => 'Cash', 'CH' => 'Cheque', 'CC' => 'Credit Card', 'VC' => 'Visa', 'MC' => 'Mastercard', 'AC' => 'Amex', 'LA' => 'Laser', '??' => 'Unknown', 'NP' => 'Not Paid' }
  end

  def self.cardname(pay_type)
    types[pay_type]
  end

  def self.countpays_for_year(date)
    Payment.by_year(date).membership_renewal_payments.real_membership_renewals.joins(:privilege).group('privileges.name, member_class').order('member_class ASC').count
  end

  def year
    date_lodged.strftime('%Y')
  end

  def check_renewal_date
    if (date_lodged.year == Time.now.utc.year) && renewal_payment?
      member.renew_date = date_lodged
      member.active = 1
      member.save
    end
  end

  def renewal_payment?
    paymenttype_id == 1 || paymenttype_id == 4
  end

  def changed_privilege?
    member.privilege_id != privilege_id
  end

  def update_member_privilege
    member.privilege_id = privilege_id
    member.save
  end

  def prior_renewal_payment
    renewal_paymenttypes = [1, 4]
    Payment.where(paymenttype_id: renewal_paymenttypes, member_id: member_id).where('id != ?', id).order(:date_lodged).last
  end

  def delete_checks
    msg = ''
    if renewal_payment?
      if prior_renewal_payment
        member.renew_date = prior_renewal_payment.date_lodged
        msg = 'Payment Deleted - Resetting Membership Renewal Date to last Renewal Date'
        member.save
        if prior_renewal_payment.privilege_id != member.privilege_id
          member.privilege_id = prior_renewal_payment.privilege_id
          msg = 'Payment Deleted - Resetting Membership Renewal Date and Membership Class'
          member.save
        end
      else
        member.renew_date = ''
      end
    end
    msg
  end
end
