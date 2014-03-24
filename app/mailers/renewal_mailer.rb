class RenewalMailer < ActionMailer::Base
  default :from => "sms@myc.ie"
   #has_attached_file :pdf_file
  
  def renewal_letter(person)
    #from = "renewals@myc.ie"
    @person = person
    file_name="#{@person.last_name}_#{@person.first_name}.pdf"
    full_file_name = Rails.root.join("tmp","email_renewals",file_name)
    pdf = PersonPdf.new(@person) #rescue nil
    pdf.render_file(full_file_name)  
    attachments[file_name] = File.read(full_file_name, :mode => 'rb')
    mail(:to => @person.email_address , :subject => "MYC Membership Renewal attached")
  end
  
  
 
  
 # def registration_confirmation(user)
 #   @user = user
 #   attachments["rails.png"] = File.read("#{Rails.root}/public/images/rails.png")
 #   mail(:to => "#{user.name} <#{user.email}>", :subject => "Registered")
 # end
  
end

