class Member < ActiveRecord::Base
  has_many :people
  has_many :payments
  has_many :boats
  belongs_to  :privilege
  has_many :peoplebarcards ,:through => :people
  has_many :loyaltycards, :through => :people

  #until strong parameters implemented accross all models..
  attr_accessible :address1, :address2, :address3, :address4, :proposed, :seconded, :year_joined, :occupation, :renew_date, :privilege_id, :name_no, :street1, :street2, :town, :city, :postcode, :county, :country, :email_renewal

  validates_presence_of :privilege_id,:proposed,:seconded,:year_joined
  validates_presence_of :street1, :message => "Please correct the members address data :- Street1 should not be blank" ,:except => :delete

  STATUSES = [ 'Active', 'Inactive']
  validates_inclusion_of :status, :in => STATUSES,
          :message => "{{value}} must be in #{STATUSES.join ','}"

  scope :current_members,  -> {where(status:  'Active') }
  scope :past_members,     -> {where(status:  'Inactive')}
  scope :internal_members, -> {where('privilege_id in (?,?)', 'X','Y' ) }
  scope :parking_members,  -> {current_members.joins(:privilege).where('car_park > 0') }

  def main_member
    people[0].main_member
  end


end
