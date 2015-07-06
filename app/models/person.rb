class Person < ActiveRecord::Base
  belongs_to :member
  has_one :privilege, :through => :member
  has_one :peoplebarcard ,:dependent => :destroy
  has_one :loyaltycard, :foreign_key => :id
  has_many :payments, :through => :member
  has_many :boats, :through => :member
  has_one :barcard, :through => :peoplebarcard

  scope :current,         -> { joins(:member,:privilege).merge(Member.current_members)  }
  scope :past,            -> { joins(:member,:privilege).merge(Member.past_members)  }
  scope :not_renewed,     -> { joins(:member,:privilege).merge(Member.not_renewed)  }
  scope :barcard_holders, -> { where.not( :status => 'g'  )   }


  validates_presence_of :last_name, :first_name,:status
  #TODO validates_presence_of :member - causes problems wth nested attributes
  validates_presence_of :email_address, :if => Proc.new {|person| person.send_email? } ,:message => "Please correct the Email address"
  validates_presence_of :mobile_phone , :if => Proc.new {|person| person.send_txt? }
  validates_format_of :email_address, :if => Proc.new {|person| person.snd_eml == "Y" }, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :status, uniqueness: {scope: :member_id, message: "Main Member already Exists check?" } , :if => Proc.new {|person| person.status == 'm' && !member_id.nil? }
  validates :status, uniqueness: {scope: :member_id, message: "Main Member already Exists"        } , :if => Proc.new {|person| person.status == 'm' && !person.member_id.nil? }
  validates :status, uniqueness: {scope: :member_id, message: "Partner Member already Exists"     },  :if => Proc.new {|person| person.status == 'p' }
  #validate :main_member_exists? ,on: :update
  #validates :status, :uniqueness => {:scope => :member_id ,:message => "Main Member does not Exist" }, :if => Proc.new {|person| person.status != 'm' }

  def self.search(params)
    people = Person.all
    people = people.current unless params[:past_members]
    people = Person.past if params[:past_members]
    people = Person.not_renewed if params[:not_renewed]
    people = people.where('last_name like :input'  , { :input => "%#{params[:search]}%"}) unless params[:search].blank?
    people = people.where('first_name like :input' , { :input => "%#{params[:searchfn]}%"}) unless params[:searchfn].blank?
    people = people.where(" people.status = 'm'" ) if params[:group]
    people = people.where('members.privilege_id = :input' ,{ :input => "#{params[:searchmp][:privilege_id]}"})  if params[:searchmp] && !params[:searchmp][:privilege_id].blank?
    people = people.paginate(:per_page => 30, :page => params[:page]).order(:last_name,:first_name)
  end

#  def main_member_exists?
#    main_member_count = Person.where("member_id = ? and status = ? ", member_id, 'm').count
#    if main_member_count != 1
#     errors.add(:status, "Must have a main member")
#    end
# end

  def adult?
    self.age >= 18 rescue nil
  end


  def self.main_person(mid)
    main_person = Person.where(" status = 'm' and member_id = ? ", mid ).first
  end

# def self.partner(mid)
#    partner = Person.where(:status => 'p',:member_id => mid ).first
# end

  def main_person?
    status == "m"
  end

  def main_member
    main_member = Person.where(status: :'m', member_id: member_id ).first
  end
  #def main_member
  #  Person.where(status: :'m' ).first
  #end

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

#  def self.members_list_type
#    {'Current Members' => 'c', 'Past and Current members' => 'p' }
#  end

  def caption
    self.last_name + ', ' +  self.first_name
  end

  # def self.proposers

  #  @proposers = Person.find(:all, :conditions => ['last_name LIKE ?', "%#{params[:search]}%"])

  # end

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
  def complete_new_person_process
    if status != 'g'
      barcard = Barcard.new
      barcard.save
      peoplebarcard = Peoplebarcard.new(:person_id => id, :barcard_id => barcard.id)
      peoplebarcard.save
    end
  end


end
