class Renewal < ActiveRecord::Base
  # validates_presence_of :subject
  validates :subject, presence: true
  def generate_completed
    update_attribute(:delivered_at, Time.now.utc)
  end

  def generate_requested
    update_attribute(:requested_at, Time.now.utc)
  end
end
