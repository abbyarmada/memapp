class Paymenttype < ActiveRecord::Base
  has_many :payments
  validates :name, presence: true

  def self.types
    Paymenttype.all.order(:name)
  end
end
