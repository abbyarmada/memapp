class Boat < ActiveRecord::Base
  belongs_to  :member
  validates_presence_of :boat_class, :boat_type,:member_id
  validates_inclusion_of :boat_type, :in => '(Dinghy,Cruiser,Motor,Windsurfer)', 
      :message => "must be Dinghy, Windsurfer, Cruiser or Motor"
  attr_accessible :boat_class, :boat_type, :boat_name ,:sail_no, :pen_tag
  scope :penboats, { :conditions => ['boat_type = ? or boat_type = ? ','Dinghy','Windsurfer'] } 
  scope :dinghy, { :conditions => ['boat_type = ? ','Dinghy'] } 
  scope :windsurfer, { :conditions => ['boat_type = ? ','Windsurfer'] } 
  scope :laser , { :conditions => ['boat_class LIKE ? ','Laser%'] }
  scope :topaz , { :conditions  => ['boat_class LIKE ? ','%Topaz%'] }
  scope :oppi , { :conditions  => ['boat_class LIKE ? ','Opti%'] }
  scope :other, { :conditions  => ['boat_class NOT IN ( ?,?,? )', 'Optimist','Topaz Uno Plus', 'Laser' ] }
  scope :members_boats,lambda { { :joins => [{:member=> [:privilege,:people]} ], :conditions => [ " ( renew_date >= ? and status = 'm')  ",Time.now.prev_year.beginning_of_year ], :order => ("last_name,first_name") }}
  def self.types
    {'Dinghy' => 'Dinghy','Cruiser' => 'Cruiser', 'Motor' => 'Motor' , 'Windsurfer' => 'Windsurfer'}
  end
end
