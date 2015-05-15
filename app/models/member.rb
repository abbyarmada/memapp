class Member < ActiveRecord::Base
  
  has_many :people , :inverse_of => :member
  has_many :payments
  has_many :boats
  belongs_to  :privilege
  has_many :peoplebarcards ,:through => :people
  has_many :loyaltycards, :through => :people
  validates_associated :people , :presence => true
  #validates_associated :people?
  #accepts_nested_attributes_for :people , :reject_if => lambda { |a| a[:content].blank? }
  accepts_nested_attributes_for :people, reject_if: proc { |attributes| attributes['first_name','last_name'].blank? }
  attr_accessible :proposed, :seconded, :year_joined, :privilege_id, :name_no, :street1, :street2, :town, :city, :postcode, :county, :country, 
  :email_renewal, :occupation, :renew_date,:created_at, :updated_at, :people_attributes
  
  validates_presence_of :privilege_id,:proposed,:seconded,:year_joined 
  validates_presence_of :street1, :message => "Please correct the members address data :- Street1 should not be blank" ,:except => :delete
  

  scope :current_members, lambda { {:include =>[ :people],:joins => [:privilege],:conditions => ['privileges.bar_reference != 0 and members.renew_date >= ? or (members.renew_date BETWEEN ? and ? and date(?) <= date(?))' , Time.now.beginning_of_year,1.year.ago.beginning_of_year,1.year.ago.end_of_year,Time.now, Time.now.year.to_s + "-05-01"   ]}}
  scope :current_and_internal_members, lambda { {:include =>[ :people],:joins => [:privilege],:conditions => ['members.renew_date >= ? or (members.renew_date BETWEEN ? and ? and date(?) <= date(?))' , Time.now.beginning_of_year,1.year.ago.beginning_of_year,1.year.ago.end_of_year,Time.now, Time.now.year.to_s + "-05-01"   ]}}
  scope :expired_members, lambda { {:include =>[ :people], :conditions => ['members.renew_date < ? ', Time.now.beginning_of_year ] } }
  scope :parking_members, lambda { { :conditions => ['privileges.car_park > ? and people.status in ( ?, ? )  ' ,  '0' ,'m' ,'p'  ]} }

  scope :memclass, lambda { |privilege| { :conditions => { :privilege_id => privilege } } }
  scope :memyear,  lambda { |memyear|   { :joins => :privilege , :conditions =>  ['renew_date >= ? and bar_reference > ? ' , memyear.to_date.beginning_of_year , 0 ]   }}
  scope :monthend, lambda { |monthend|  { :joins => :privilege , :conditions =>  ['renew_date <= ?  and bar_reference > ? ' ,  monthend.end_of_month, 0 ]   }}

  scope :unique_proposers , group(:proposed)
  scope :unique_seconders , group(:seconded)
  
  def self.membership(mid)
    membership = Member.find_by_id mid
  end

  def self.overduesubs

    this_yr_start = Time.now.year.to_s + "-01-01"
    last_yr_start = (Time.now.year - 1).to_s + "-01-01"

    @overduesubs = Member.find :all,
               :include => [:people,:privilege],
               :conditions => "people.status = 'm' and member_class not in ('T','E') and renew_date < '#{this_yr_start}' and renew_date >= '#{last_yr_start}' "
  end

  def self.memberships
    this_yr_start = Time.now.year.to_s + "-01-01"

    @memberships = Member.count :include => [:privilege],
                :conditions => " bar_reference != 0 and (  renew_date >= '#{this_yr_start}' ) "
  end

  def main_member
    Person.where(:member_id => id ,:status => 'm' ).first
  end
end

