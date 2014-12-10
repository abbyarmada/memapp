class Member < ActiveRecord::Base
  has_many :people
  has_many :payments
  has_many :boats
  belongs_to  :privilege
  has_many :peoplebarcards ,:through => :people
  has_many :loyaltycards, :through => :people

  accepts_nested_attributes_for :people
  validates_associated :people

  validates_presence_of :privilege_id,:proposed,:seconded,:year_joined
  validates_presence_of :street1, :message => "Please correct the members address data :- Street1 should not be blank" ,:except => :delete

  STATUSES = [ 'Active', 'Inactive']
  validates_inclusion_of :status, :in => STATUSES,
          :message => "{{value}} must be in #{STATUSES.join ','}"

  scope :current_members,  -> {where(status:  'Active') }
  scope :past_members,     -> {where(status:  'Inactive')}
  scope :internal_members, -> {where('privilege_id in (?,?)', 'X','Y' ) }
  scope :parking_members,  -> {current_members.joins(:privilege).where('car_park > 0') }
  scope :not_renewed,      -> {where('renew_date  >= ? and renew_date < ?',
    1.year.ago.beginning_of_year,Time.now.beginning_of_year )}

  def main_member
    people[0].main_member
  end
  def self.overduesubs
    not_renewed.joins(:people).where("people.status = 'm' ")
  end
  def complete_new_member_process
    main_member.complete_new_person_process
  end
  
end
