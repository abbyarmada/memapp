class Privilege < ActiveRecord::Base
   has_many :members
   has_many :payments#, :through => :members
   has_many :people,:through => :members
   has_many :subscriptions

   validates_presence_of :member_class, :name, :bar_billies,:car_park,:votes,:boat_storage
   validates_numericality_of :votes,:bar_reference,:car_park
   validates_uniqueness_of :member_class
   validates_inclusion_of :bar_billies, :in => '(Y,N)', :message => "must be Y or N"
   attr_accessible :member_class, :name, :bar_billies, :car_park,:votes, :bar_reference, :boat_storage
   #validates_length_of :member_class, :maximum => 1

   def self.types
      types = find :all    #, :order => "name"
   end

  def self.billie_cutoff_date
    billie_cutoff_date = (Time.now.year.to_s + "-03-01").to_time
  end


end
