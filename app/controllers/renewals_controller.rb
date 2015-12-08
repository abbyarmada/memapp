class RenewalsController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:generate_pdfs]

  #before_action :set_model, only: [:generate_pdfs,:generate_emails]
  respond_to :html, :zip

  def generate_pdfs
    @renewal = Renewal.find(params[:id])
    @renewal.generate_requested
#    puts "calling rake from controller"
  #Rake::Task[create_renewal_pdfs, renewal_id: 1]
  #{}%x[rake renewal:create_renewal_pdfs :renewal_id => 1]
  #  call_rake :create_renewal_pdfs, :renewal_id => params[:id].to_i
     system("rake create_renewal_pdfs RENEWAL_ID='1' & ")

    #system("rake","create_renewal_pdfs RENEWAL_ID='1' & ")

    #call_rake :create_renewal_pdfs, :renewal_id => params[:id].to_i

#    system "/usr/bin/rake #{task}  --trace 2>&1 >> #{Rails.root}/log/rake.log &"

    flash[:notice] = "Generating PDF Documents... Please wait... refresh page and the time below will be updated.. when completed - can be up to 10 minutes."
    redirect_to renewals_url
  end

  def generate_emails
    @renewal = Renewal.find(params[:id])
    @renewal.generate_requested
    #call_rake :create_renewal_emails, :renewal_id => 2
    #Rake::Task[create_renewal_emails, renewal_id: 2]
    system("rake create_renewal_emails RENEWAL_ID='2' & ")
    flash[:notice] = "Emails are being generated and sent in the background."
    redirect_to renewals_url
  end

  def download_zip
     path = Rails.root.join("tmp","renewals","Renewals_For_Printing.zip")
     File.open(path,'rb') do |f|
        send_data f.read, :type => 'application/zip',:filename => 'Renewals_For_Printing.zip', :disposition => 'attachment', :encoding => 'utf8'
     end
  end

  def index
    @renewals = Renewal.all
  end

  def show

  end

  def new
    @renewal = Renewal.new
  end

  def create
    @renewal = Renewal.new(renewal_params)
    if @renewal.save
      flash[:notice] = "Successfully created Renewal."
      redirect_to @renewal
    else
      render :action => 'new'
    end
  end

  def edit

  end

  def update
    if @renewal.update(renewal_params)
      flash[:notice] = "Successfully updated Renewal."
      respond_with(@renewal)
    end
  end

  def destroy
    @renewal.destroy
    flash[:notice] = "Successfully destroyed Renewal."
    redirect_to renewals_url
  end

  private
  def set_model
    @renewal = Renewal.find(params[:id])
  end

  def renewal_params
    params.require(:renewal).
      permit(:subject,:content,:delivered_at,:requested_at)
  end

end
