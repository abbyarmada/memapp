class Subscription < ActiveRecord::Base

  belongs_to :privilege # foreign key privilege_id
  
  validates_presence_of :amount,:privilege_id,:start_date,:end_date
  attr_accessible :amount,:privilege_id,:start_date,:end_date
 #def self.lastyear(privilege_id)
   # lastyear = (subscription.find :all, :conditions => [ 'privilege_id = ? and start_date <= ? and end_date >= ? ' , privilege_id ,1.year.ago.beginning_of_year ,1.year.ago.end_of_year ])
 # end


 #def self.main_person(mid)
 #   main_person = Person.find_by_status "m" ,:conditions => " member_id = '#{mid}'"
 # end
 

  scope :lastyear, ->  { { :where =>  ['start_date >= ? and end_date <= ?   ' , 1.year.ago.beginning_of_year ,1.year.ago.end_of_year   ] } }
  scope :thisyear, ->  { { :where =>  ['start_date >= ? and end_date <= ?   ' , Time.now.beginning_of_year ,Time.now.end_of_year   ] } }
  scope :nextyear, ->  { { :where =>  ['start_date >= ? and end_date <= ?   ' , 1.year.from_now.beginning_of_year ,1.year.from_now.end_of_year   ] } }

#  
#  named_scope :current_subs,  lambda { |current_subs|   { :conditions =>  ['start_date <= ? and privilege_id = ? ' , time.now, privilege_id  ] } }
#  named_scope :nextyear_subs, lambda { { :conditions => ['start_date >= ?', (time.now.year + 1).start_of_year  ] } }
  
  #named_scope :memclass,     lambda { |privilege|      {                        :conditions => { :privilege_id => privilege } } }
  #named_scope :memyear,      lambda { |memyear|        { :joins => :privilege , :conditions =>  ['renew_date >= ? and bar_reference > ? ' , memyear.to_date.beginning_of_year , 0 ]   }}
  #named_scope :monthend, lambda { |monthend|  { :joins => :privilege , :conditions =>  ['renew_date <= ?  and bar_reference > ? ' ,  monthend.end_of_month, 0 ]   }}
   
end
