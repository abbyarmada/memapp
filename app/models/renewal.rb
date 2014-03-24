class Renewal < ActiveRecord::Base
  def generate_completed
    update_attribute(:delivered_at, Time.now)
  end
  def generate_requested
    update_attribute(:requested_at, Time.now)
  end
end
