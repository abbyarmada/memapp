class Paymenttype < ActiveRecord::Base
  has_many :payments
  validates_presence_of :name
  def self.types
      types = find :all, :order => "description"
  end

end
