class LettersController < ApplicationController

  layout 'letters_layout'
  
  #include PdfHelper
  
  def renewal
    # find the selected person
    @person = Person.find(params[:id])
    @boats  = @person.member.boats.find(:all)
    
    @boats_reg_text = "You have 1 boat registered" 
    if @boats.size > 1 
      @boats_reg_text = "You have #{@boats.size} boats registered" 
    end
  
 
  
    # get his member details
    #@m = @p.member
    # get his partner (if there is one)
    #@pp = @m.people.find :all, :conditions => "status = 'p'"
    # find the latest payment
    #@lp = @m.payments.find :first, :order => "date_lodged DESC"
   # @pid = @p.id
    
    # TODO this is simple for testing and needs to be corrected
    #@dear = @p.first_name
    #if @pp[0]
    #  @dear += " & " + @pp[0].first_name
   # end
    #@this_year = Time.now.year.to_s
   # bvdate = (@this_year + "-02-05").to_date
   # @bv = @lp.date_lodged.to_date < bvdate
   # @end_bv = (@this_year + "-09-30").to_date.to_s
   # @end_pp = (((Time.now.year) +1).to_s + "-03-31").to_date.to_s
   # @nbv = 2 # TODO need to work this out
   # @npermits = 2 # TODO need to work this out
    
  end # renewal

  
  def make_pdf(pdf_action, pdf_name, pid, landscape=false)
      prince = Prince.new()
      # Sets style sheets on PDF renderer.
      prince.add_style_sheets(
        "#{RAILS_ROOT}/public/stylesheets/letters.css"
      )
      # Render the estimate to a big html string.
      # Set RAILS_ASSET_ID to blank string or rails appends some time after
      # to prevent file caching, screwing up local - disk requests.
      ENV["RAILS_ASSET_ID"] = ''
      
      #html_string = render_to_string(:template => template_path, :layout => 'myc_layout')
      
            @p = Person.find(pid)
            # get his member details
            @m = @p.member
            # get his partner (if there is one)
            @pp = @m.people.find :all, :conditions => "status = 'p'"
            # find the latest payment
            @lp = @m.payments.find :first, :order => "date_lodged DESC"
            @pid = @p.id

            # TODO this is simple for testing and needs to be corrected
            @dear = @p.first_name
            if @pp[0]
              @dear += " & " + @pp[0].first_name
            end
            @this_year = Time.now.year.to_s
            bvdate = (@this_year + "-02-05").to_date
            @bv = @lp.date_lodged.to_date < bvdate
            @end_bv = (@this_year + "-09-30").to_date.to_s
            @end_pp = (((Time.now.year) +1).to_s + "-03-31").to_date.to_s
            @nbv = 2 # TODO need to work this out
            @npermits = 2 # TODO need to work this out
    
      html_string = render_to_string(:action => pdf_action)
      
      # Make all paths relative, on disk paths...
      html_string.gsub!("src=\"", "src=\"#{RAILS_ROOT}/public")
      # Send the generated PDF file from our html string.
      return prince.pdf_from_string(html_string)
    end
  
    # Makes and sends a pdf to the browser
    #
    def try_pdf
      pdf_action = 'renewal'
      pdf_name = 'test3.pdf'
      landscape = false
      pid = params[:id]
      send_data(
        make_pdf(pdf_action, pdf_name, pid, landscape),
        :filename => pdf_name,
        :type => 'application/pdf'
      ) 
    end
  
end