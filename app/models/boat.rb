class Boat < ActiveRecord::Base
  belongs_to  :member
  has_many :people ,:through => :members

  validates_presence_of :boat_class, :boat_type,:member_id
  validates_inclusion_of :boat_type, in: %W(Dinghy Cruiser Motor Windsurfer), :message => "must be Dinghy, Windsurfer, Cruiser or Motor"
  attr_accessible :boat_class, :boat_type, :boat_name ,:sail_number, :pen_tag, :member_id
  
  scope :penboats, -> { where( ['boat_type = ? or boat_type = ? ','Dinghy','Windsurfer'] ) }
  
  scope :dinghy, -> { where( ['boat_type = ? ','Dinghy'] ) }
  
  scope :windsurfer, ->  { where( ['boat_type = ? ','Windsurfer'] ) }
  
  scope :laser , ->  { where( ['boat_class LIKE ? ','Laser%'] ) }
  
  scope :topaz ,  -> { where( ['boat_class LIKE ? ','Topaz Uno Plus%'] ) }
  
  scope :oppi ,  -> { where( ['boat_class LIKE ? ','Opti%'] ) }
  
  scope :other, ->  { where( ['boat_class NOT IN ( ?,?,? )', 'Optimist','Topaz Uno Plus', 'Laser' ] ) }
  
  scope :members_boats, ->  { where('members.renew_date >= ? and people.status = \'m\'  '  , Time.now.prev_year.beginning_of_year).joins(:member => [:privilege,:people]) }

   
  def self.types
    {'Dinghy' => 'Dinghy','Cruiser' => 'Cruiser', 'Motor' => 'Motor' , 'Windsurfer' => 'Windsurfer'}
  end
  
  def owner
    Member.main_member
  end

end
