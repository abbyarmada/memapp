class Loyaltycard < ActiveRecord::Base
   
   belongs_to :person
   belongs_to :member
   
  
end
