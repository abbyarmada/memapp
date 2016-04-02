class Privilege < ActiveRecord::Base
  # attr_accessible :bar_billies, :bar_reference, :boat_storage, :car_park, :member_class,
  # :name, :vote, :amount, :start_date, :end_date, :privilege_id
  has_many :members
  has_many :payments, through: :members
  has_many :people, through: :members
  has_many :subscriptions
  validates :member_class, :name, :bar_billies, :car_park, :votes, :boat_storage, :bar_reference, presence: true
  validates :votes, :bar_reference, :car_park, presence: true
  validates :member_class, uniqueness: true
  validates :bar_billies, inclusion: { in: %w(Y N), message: 'must be Y or N' }
  validates :member_class, length: { maximum: 1 }

  scope :real_member, -> { where(bar_reference: 1) }

  before_save { |privilege| privilege.member_class.upcase! }

  def self.billie_cutoff_date
    (Time.now.utc.year.to_s + '-03-01').to_date
  end
end
