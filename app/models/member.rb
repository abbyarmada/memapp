class Member < ActiveRecord::Base
  has_many :people
  has_many :payments
  has_many :boats
  belongs_to  :privilege
  has_many :peoplebarcards ,:through => :people
  has_many :loyaltycards, :through => :people
  has_many :paymenttypes, :through => :payments

  accepts_nested_attributes_for :people
  validates_associated :people

  validates_presence_of :privilege_id,:proposed,:seconded,:year_joined,:active
  validates_presence_of :street1, :message => "Please correct the members address data :- Street1 should not be blank" ,:except => :delete


  scope :active_members,  -> {where(active: true ) }
  scope :inactive_members,     -> {where(active: false)}
  scope :internal_members, -> {where('privilege_id in (?,?)', 'X','Y' ) }
  scope :not_renewed,      -> {where('members.renew_date  >= ? and members.renew_date < ?',
    1.year.ago.beginning_of_year,Time.now.beginning_of_year )}
  scope :renewed,      -> {where('members.renew_date  >= ?',Time.now.beginning_of_year )}
  scope :current_members, -> { active_members }
  scope :parking_members,  -> {current_members.joins(:privilege).where("privileges.car_park > 0") }

  scope :past_members, ->  { where(' ( members.renew_date  >= ? and members.renew_date < ? )  or members.active = ? ',
    1.year.ago.beginning_of_year,Time.now.beginning_of_year, 0  )}


  def main_member
    people[0].main_member
  end
  def self.overduesubs
    not_renewed.joins(:people).where("people.status = 'm' ")
  end
  def complete_new_member_process
    self.people[0].complete_new_person_process
  end

end
