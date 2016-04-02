class Boat < ActiveRecord::Base
  belongs_to :member
  validates :boat_class, :boat_type, :member_id, presence: true
  # validates :boat_type, inclusion: { in: %w(Dinghy Cruiser Motor Windsurfer) }, message: 'must be Dinghy, Windsurfer, Cruiser or Motor'

  scope :penboats, -> { where(['boat_type = ? or boat_type = ? ', 'Dinghy', 'Windsurfer']) }

  scope :dinghy, -> { where(['boat_type = ? ', 'Dinghy']) }

  scope :windsurfer, -> { where(['boat_type = ? ', 'Windsurfer']) }

  scope :kona, -> { where(['boat_class LIKE ? ', 'Kona%']) }

  scope :laser, -> { where(['boat_class LIKE ? ', 'Laser%']) }

  scope :topaz, -> { where(['boat_class LIKE ? ', 'Topaz Uno Plus%']) }

  scope :oppi, -> { where(['boat_class LIKE ? ', 'Opti%']) }

  scope :canoe, -> { where(['boat_class LIKE ? ', 'Canoe%']) }

  scope :other, -> { where(['boat_class NOT IN ( ?,?,?,?,?,?)', 'Optimist', 'Topaz Uno Plus', 'Laser', 'Kona', 'Kona One', 'Canoe']) }

  scope :members_boats, -> { joins(:member).merge(Member.current_members).merge(Person.grouped).includes([member: :people], [member: :privilege]).order('people.last_name,people.first_name') }

  def self.types
    { 'Dinghy' => 'Dinghy', 'Cruiser' => 'Cruiser', 'Motor' => 'Motor', 'Windsurfer' => 'Windsurfer' }
  end

  def owner
    member.main_member
  end
end
