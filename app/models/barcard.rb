class Barcard < ActiveRecord::Base
  # barcard numbers are assigned by the database. 
  # they should never be re-used as this may present the possibility of an account in the Bar system being re-activiated. 
  # care should be taken !!! 
  # Modify only the peoplebarcards which is the link from Person to Bar accounts. 
 
  has_many :peoplebarcards

end


