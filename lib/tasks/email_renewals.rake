desc "Generate Email Renewals"
task :create_renewal_emails => :environment do
  include ActionView::Helpers::NumberHelper
  renewal = Renewal.find(ENV["RENEWAL_ID"])
  last_yr_start = (Time.now.year - 1).to_s + "-01-01"
     @renews = Person.find :all, :include => [:member],
     :conditions =>  "members.email_renewal = 'Y' and people.status = 'm' and ( members.renew_date  >= '#{last_yr_start}' or members.year_joined = Year(CURDATE()) ) AND members.privilege_id not in ('1','3','11','13','14')",
     :order => "members.country,members.county,members.city,members.town,members.street1"
     @renews.each do |person| @person = person
       RenewalMailer.renewal_letter(@person).deliver_now
     end
   renewal.generate_completed
end
