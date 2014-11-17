class Person < ActiveRecord::Base
  belongs_to :member   #, :inverse_of => :people
  has_one :privilege, :through => :member
  has_one :peoplebarcard ,:dependent => :destroy
  has_one :loyaltycard, :foreign_key => :id
  has_many :payments, :through => :member
  has_many :boats, :through => :member
  has_one :barcard, :through => :peoplebarcard
  
  accepts_nested_attributes_for :member

  attr_accessible :id,:member_id,:first_name,:last_name,:status,:child_dob,:home_phone,:mobile_phone,:email_address,:comm_prefs,:snd_txt,:snd_eml,:dob,:member_number ,:txt_bridge , :txt_social, :txt_crace,
  :txt_cruiser_race_skipper, :txt_cruising, :txt_cruiser_skipper, :txt_dinghy_sailing, :txt_junior, :txt_test, :txt_op_co, :occupation , :send_txt, :send_email , :member_attributes


  scope :current, lambda { {:include => :member,:conditions => [' ( members.renew_date >= ? or (members.renew_date BETWEEN ? and ? and date(?) <= date(?))) ' , Time.now.beginning_of_year,1.year.ago.beginning_of_year,1.year.ago.end_of_year,Time.now, Time.now.year.to_s + "-05-01" ]}}

  validates_presence_of :last_name, :first_name,:status, :member_id
 validates_presence_of :email_address, :if => Proc.new {|person| person.send_email? } ,:message => "Please correct the Email address"
  validates_presence_of :mobile_phone , :if => Proc.new {|person| person.send_txt? }
  validates_format_of :email_address, :if => Proc.new {|person| person.snd_eml == "Y" }, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :status, :uniqueness => {:scope => :member_id ,:message => "Main Member already Exists" },  :if => Proc.new {|person| person.status == 'm' }
  validates :status, :uniqueness => {:scope => :member_id ,:message => "Partner Member already Exists" },  :if => Proc.new {|person| person.status == 'p' }
  validate :main_member_exists?, :message=>"Must have a main member",  on: :update 
  #validates :status, :uniqueness => {:scope => :member_id ,:message => "Main Member does not Exist" }, :if => Proc.new {|person| person.status != 'm' }

  def self.search(params)
    people = scoped
    people = people.current unless params[:past_members]
    people = people.where('last_name like :input'  , { :input => "%#{params[:search]}%"}) unless params[:search].blank?
    people = people.where('first_name like :input' , { :input => "%#{params[:searchfn]}%"}) unless params[:searchfn].blank?
    people = people.where(" people.status = 'm'" ) if params[:group]
    people = people.where('members.privilege_id = :input' ,{ :input => "#{params[:searchmp][:privilege_id]}"})  if params[:searchmp] && !params[:searchmp][:privilege_id].blank?
    people = people.order(:last_name, :first_name).includes({:member => :privilege},:peoplebarcard,:loyaltycard).paginate(:per_page => 30, :page => params[:page])
  end

  def main_member_exists?
    main_member_count = self.class.count(:conditions => ["member_id = ? and status = ? ", self.member_id, 'm']) 
      if main_member_count != 1  
      errors.add(:status, "Must have a main member")
    end
  end

  def adult?
    self.age >= 18 rescue nil
  end

  def self.main_person(mid)
    main_person = Person.where(" status = 'm' and member_id = ? ", mid ).first
  end

  def self.partner(mid)
    partner = Person.where(:status => 'p',:member_id => mid ).first
  end

  def self.main_person?
    if Person.status = "m"
    end
  end

  def self.main_member(pid)
    main_member = Person.where(:status => 'm' ,:member_id => "select member_id from people where id = '#{pid}'").first
  end

  def self.status
    #{'m' =>'Main Member', 'ch' => 'Child of main member' , 'p' => 'Partner of main member' ,'g' => 'Parent/Guardian of Cadet Member'}
    {"Main Member" => "m", "Child of main member" => "ch" , "Partner of main member" => "p", "Parent/Guardian of Cadet Member" => "g"}
  end
  def self.form_status(new_member)
    if new_member
      {"Main Member" => "m", "Child of main member" => "ch" , "Partner of main member" => "p", "Parent/Guardian of Cadet Member" => "g"}
     else
      {"Child of main member" => "ch" , "Partner of main member" => "p", "Parent/Guardian of Cadet Member" => "g"} 
    end
  end
  def status_name
    #used for the PDF Renewal forms
    case status
    when "m"
      'Main Member'
    when "p"
      'Partner'
    when "ch"
      'Cadet'
    when "g"
      'Parent'
    end
  end

  def self.members_list_type
    {'Current Members' => 'c', 'Past and Current members' => 'p' }
  end

  def caption
    self.last_name + ', ' +  self.first_name
  end

  def url
    "person/edit/" + self.id.to_s
  end

  def self.peoplecount
    this_yr_start = Time.now.year.to_s + "-01-01"

    @peoplecount = Person.count :include => [:member ],
                :joins => " inner join privileges on members.privilege_id = privileges.id ",
                :conditions => " (  renew_date >= '#{this_yr_start}' ) and privileges.bar_reference > 0 "
  end

  def self.proposers

    @proposers = Person.find(:all, :conditions => ['last_name LIKE ?', "%#{params[:search]}%"])

  end

  def partner
    partner = Person.where(:status => 'p', :member_id => member_id ).first if status == 'm' 
  end

  def salutation_first_names
    if partner
      salutation = [first_name,partner.first_name].join(' & ')
    else
      salutation = first_name
    end
  end


  def salutation
    if  partner
      if partner.last_name == last_name
        salutation = [[first_name,partner.first_name].join(' & '),last_name].join(' ')
      else
        salutation = [[first_name,last_name].join(' '), [partner.first_name,partner.last_name].join(' ')].join(' & ')
      end
    else
      salutation = [first_name,last_name].join(' ')
    end
  end

def age
  ((Date.today - dob) / 365).to_i rescue nil
  end

  def main_person(member_id)
    Person.where(:status => 'm', :member_id => member_id).first
  end

end

