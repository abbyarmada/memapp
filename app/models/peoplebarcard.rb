class Peoplebarcard < ActiveRecord::Base
  belongs_to :person
  belongs_to :barcard
 # belongs_to :member
  def self.familybarcards(member_id)
    self.find :all, 
      :select => "peoplebarcards.*, concat(lpad(peoplebarcards.barcard_id,5,'0'),' - ',people.first_name,' ' ,people.last_name) as selectlist ",
      :include =>[:person] , :joins => "inner join people on peoplebarcards.person_id = people.id ", 
      :conditions => ("member_id = #{member_id}" ) 
  end
end

