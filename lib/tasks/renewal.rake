desc "Generate Renewal PDF's"
task :create_renewal_pdfs => :environment do

  include ActionView::Helpers::NumberHelper
  renewal = Renewal.find(ENV["RENEWAL_ID"])
  #Mark start time..
  #renewal.generate_requested
  puts Time.now

  Dir.mkdir("tmp") unless Dir.exists?("tmp")
  Dir.mkdir("tmp/renewals") unless Dir.exists?("tmp/renewals")

# Delete previous PDF's
  file_path = Rails.root.join("tmp","renewals")
  Dir.foreach(file_path){|file| File.delete(file_path+file) if (/^.*.pdf$/).match(file)} if File.exist?(file_path)
  
  last_yr_start = (Time.now.year - 1).to_s + "-01-01"
     @renews = Person.find :all, :include => [:member],
     :conditions =>  "members.email_renewal = 'N' and people.status = 'm' and ( members.renew_date  >= '#{last_yr_start}' or members.year_joined = Year(CURDATE()) ) AND members.privilege_id not in ('1','3','11','13','14')",
     :order => "members.country,members.county,members.city,members.town,members.street1"
     @renews.each do |person| @person = person
        pdf = PersonPdf.new(@person) #rescue nil
        pdf.render_file( Rails.root.join("tmp","renewals","#{@person.last_name}_#{@person.first_name}.pdf"))  
     end
     Rake::Task["zipfiles"].execute
     puts "Current dir: #{File.expand_path(".")}"
     renewal.generate_completed
end


