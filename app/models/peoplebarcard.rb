class Peoplebarcard < ActiveRecord::Base
  belongs_to :person
  belongs_to :barcard
  belongs_to :member

end
