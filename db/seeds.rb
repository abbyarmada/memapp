Renewal.delete_all
["Generate Renewals","Email Renewals"].each do |subject|
  Renewal.create(:subject => subject, :delivered_at => Time.now - 1 , :requested_at => Time.now )
end

