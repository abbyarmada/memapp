class RenewalsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:generate_pdfs]
  def generate_pdfs
    @renewal = Renewal.find(params[:id])
    @renewal.generate_requested
    puts "calling rake from controller"
    call_rake :create_renewal_pdfs, :renewal_id => 1
    task = 'create_renewal_pdfs'
    args = 'rewnewal_id=1'
#    system "/usr/bin/rake #{task}  --trace 2>&1 >> #{Rails.root}/log/rake.log &"

    flash[:notice] = "Generating PDF Documents... Please wait... refresh page and the time below will be updated.. when completed - can be up to 10 minutes."
    redirect_to renewals_url
  end
  
  def generate_emails
    @renewal = Renewal.find(params[:id])
    @renewal.generate_requested
    call_rake :create_renewal_emails, :renewal_id => 2
    flash[:notice] = "Emails are being generated and sent in the background."
    redirect_to renewals_url
  end
  
  def download_zip
     path = Rails.root.join("tmp","renewals","Renewals_For_Printing.zip")
#     puts "path=" +path.to_s
     File.open(path,'rb') do |f|
        send_data f.read, :type => 'application/zip',:filename => 'Renewals_For_Printing.zip', :disposition => 'attachment', :encoding => 'utf8'
     end
  end
  
  def index
    @renewals = Renewal.find(:all)
  end
  
  def show
    @renewal = Renewal.find(params[:id])
  end
  
  def new
    @renewal = Renewal.new
  end
  
  def create
    @renewal = Renewal.new(params[:renewal])
    if @renewal.save
      flash[:notice] = "Successfully created Renewal."
      redirect_to @renewal
    else
      render :action => 'new'
    end
  end
  
  def edit
    @Renewal = Renewal.find(params[:id])
  end
  
  def update
    @renewal = Renewal.find(params[:id])
    if @renewal.update_attributes(params[:renewal])
      flash[:notice] = "Successfully updated Renewal."
      redirect_to @renewal
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @renewal = Renewal.find(params[:id])
    @renewal.destroy
    flash[:notice] = "Successfully destroyed Renewal."
    redirect_to renewals_url
  end
end
