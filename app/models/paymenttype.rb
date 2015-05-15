class Paymenttype < ActiveRecord::Base
  has_many :payments
  
  def self.types   
      types = find :all, :order => "description"
  end
  
end
