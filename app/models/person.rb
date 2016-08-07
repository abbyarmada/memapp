class Person < ActiveRecord::Base
  belongs_to :member
  has_one :privilege, through: :member
  has_one :peoplebarcard, dependent: :destroy
  has_one :loyaltycard, foreign_key: :id
  has_many :payments, through: :member
  has_many :boats, through: :member
  has_one :barcard, through: :peoplebarcard

  scope :current,         -> { joins(:member, :privilege).merge(Member.current_members) }
  scope :past,            -> { joins(:member, :privilege).merge(Member.past_members) }
  scope :not_renewed,     -> { joins(:member, :privilege).merge(Member.not_renewed) }
  scope :barcard_holders, -> { where.not(status: 'g') }
  scope :grouped,         -> { where(status: 'm') }

  validates :last_name, :first_name, :status, presence: true
  validates :email_address, if: proc { |person| person.send_email? }, presence: { message: 'Please correct the Email address' }
  validates :mobile_phone, if: proc { |person| person.send_txt? }, presence: true
  validates :email_address, if: proc { |person| person.snd_eml == 'Y' }, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, presence: true
  validates :status, uniqueness: { scope: :member_id, message: 'Main Member already Exists check?' }, if: proc { |person| person.status == 'm' && !member_id.nil? }
  validates :status, uniqueness: { scope: :member_id, message: 'Main Member already Exists'        }, if: proc { |person| person.status == 'm' && !person.member_id.nil? }
  validates :status, uniqueness: { scope: :member_id, message: 'Partner Member already Exists'     }, if: proc { |person| person.status == 'p' }
  # validate :main_member_exists? ,on: :update
  # validates :status, :uniqueness => {:scope => :member_id ,:message => "Main Member does not Exist" }, :if => Proc.new {|person| person.status != 'm' }

  def self.search(params)
    people = Person.all.includes([member: :privilege], :peoplebarcard)
    people = people.current unless params[:past_members]
    people = Person.past if params[:past_members]
    people = Person.not_renewed if params[:not_renewed]
    people = people.where('last_name like :input', input: "%#{params[:search]}%") unless params[:search].blank?
    people = people.where('first_name like :input', input: "%#{params[:searchfn]}%") unless params[:searchfn].blank?
    people = people.grouped if params[:group]
    people = people.where('members.privilege_id = :input', input: (params[:searchmp][:privilege_id]).to_s) if params[:searchmp] && !params[:searchmp][:privilege_id].blank?
    people.paginate(per_page: 30, page: params[:page]).order(:last_name, :first_name)
  end

  #  def main_member_exists?
  #    main_member_count = Person.where("member_id = ? and status = ? ", member_id, 'm').count
  #    if main_member_count != 1
  #     errors.add(:status, "Must have a main member")
  #    end
  # end

  def adult?
    age.present? ? age >= 18 : nil
  end

  def self.main_person(member_id)
    Person.find_by(status: 'm', member_id: member_id)
  end

  def main_person?
    status == 'm'
  end

  def main_member
    Person.find_by(status: 'm', member_id: member_id)
  end

  def self.status
    { 'Main Member' => 'm', 'Child of main member' => 'ch', 'Partner of main member' => 'p', 'Parent/Guardian of Cadet Member' => 'g' }
  end

  def self.form_status(new_member)
    if new_member
      { 'Main Member' => 'm', 'Child of main member' => 'ch', 'Partner of main member' => 'p', 'Parent/Guardian of Cadet Member' => 'g' }
    else
      { 'Child of main member' => 'ch', 'Partner of main member' => 'p', 'Parent/Guardian of Cadet Member' => 'g' }
    end
  end

  def status_name
    # used for the PDF Renewal forms
    case status
    when 'm'
      'Main Member'
    when 'p'
      'Partner'
    when 'ch'
      'Cadet'
    when 'g'
      'Parent'
    end
  end

  def caption
    last_name + ', ' + first_name
  end

  def partner
    Person.find_by(status: 'p', member_id: member_id) if status == 'm'
  end

  def salutation_first_names
    return first_name unless partner
    [first_name, partner.first_name].join(' & ')
  end

  def salutation
    return [first_name, last_name].join(' ') unless partner
    if same_surname?
      [[first_name, partner.first_name].join(' & '), last_name].join(' ')
    else
      [[first_name, last_name].join(' '), [partner.first_name, partner.last_name].join(' ')].join(' & ')
    end
  end

  def age
    dob.present? ? ((Time.zone.today - dob) / 365).to_i : ' '
  end

  def same_surname?
    partner.last_name == last_name
  end

  def complete_new_person_process
    if status != 'g'
      barcard = Barcard.new
      barcard.save
      peoplebarcard = Peoplebarcard.new(person_id: id, barcard_id: barcard.id)
      peoplebarcard.save
    end
  end
end
