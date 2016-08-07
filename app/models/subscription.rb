class Subscription < ActiveRecord::Base
  belongs_to :privilege

  validates :amount, :privilege_id, :start_date, :end_date, presence: true

  def self.subscription_for_year(date)
    sub = where('start_date <= ?', date).order(start_date: :desc).first
    sub.amount
  end

  default_scope { order(end_date: :desc, start_date: :desc) }

  scope :lastyear, -> (_privilege) { subscription_for_year(1.year.ago) }
  scope :thisyear, -> (_privilege) { subscription_for_year(Time.now.utc) }
  scope :nextyear, -> (_privilege) { subscription_for_year(1.year.from_now) }
end
