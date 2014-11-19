class Privilege < ActiveRecord::Base
  attr_accessible :bar_billies, :bar_reference, :boat_storage, :car_park, :member_class, :name, :votes
  has_many :members
  has_many :payments#, :through => :members
  has_many :people,:through => :members
  has_many :subscriptions
  validates_presence_of :member_class, :name, :bar_billies,:car_park,:votes,:boat_storage,:bar_reference
  validates_numericality_of :votes,:bar_reference,:car_park
  validates_uniqueness_of :member_class
  validates_inclusion_of :bar_billies, in:  %w(Y N), :message => "must be Y or N"
  #validates_length_of :member_class, :maximum => 1

  def self.types   
    types = find :all    #, :order => "name"
  end

  def self.billie_cutoff_date
    billie_cutoff_date = (Time.now.year.to_s + "-03-01").to_time
  end
end
