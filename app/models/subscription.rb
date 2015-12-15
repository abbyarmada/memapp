class Subscription < ActiveRecord::Base

  belongs_to :privilege # foreign key privilege_id

  validates_presence_of :amount,:privilege_id,:start_date,:end_date

  def self.subscription_for_year(date)
    sub = where("start_date <= ?", date).order(start_date: :desc).first
    sub.amount
  end



  default_scope { order(end_date: :desc, start_date: :desc) }

  scope :lastyear, -> privilege {subscription_for_year(1.year.ago)}
  scope :thisyear, -> privilege {subscription_for_year(Time.now)}
  scope :nextyear, -> privilege {subscription_for_year(1.year.from_now)}
end
