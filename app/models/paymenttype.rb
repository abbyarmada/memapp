class Paymenttype < ActiveRecord::Base
  has_many :payments
  attr_accessible :name
  def self.types   
      types = find :all, :order => "description"
  end
  
end
