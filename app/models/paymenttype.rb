class Paymenttype < ActiveRecord::Base
  has_many :payments
  validates_presence_of :name
  def self.types
      types = Paymenttype.all.order(:name)
  end

end
