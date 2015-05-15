class Loyaltycard < ActiveRecord::Base
   
   belongs_to :person
   belongs_to :member
  alias_attribute :Current_Points, :'Current Points'
  
end
