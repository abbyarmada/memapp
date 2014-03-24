# encoding: utf-8

 new_entry_fields_background_colour = 'B8B8B8'
 new_entry_fields_txt_colour  = 'ffffff'
 entry_fields_background_colour = 'ffffff'
 entry_fields_txt_colour  = '888888'
 

 @commspref  = @person.member.people.map do |person|
    [   
        person.first_name, 
        person.email_addr,       
        person.snd_txt,
        person.snd_eml,
        person.txt_social.zero? ? ' ': 'Y',
        person.txt_crace.zero? ? ' ': 'Y',
        person.txt_cruiser_race_skipper.zero? ? ' ': 'Y',
        person.txt_cruising.zero? ? ' ': 'Y',
        person.txt_cruiser_skipper.zero? ? ' ': 'Y',
        person.txt_dinghy_sailing.zero? ? ' ': 'Y',
        person.txt_junior.zero? ? ' ': 'Y'   ,
        person.txt_op_co.zero? ? ' ': 'Y' ,
        sort = case person.status_name
            when 'Main Member' then 1
            when 'Partner' then 2
            when 'Cadet' then 3
            when 'Parent' then 4
        end
        
    ]
    end
    
    
 @commspref = @commspref.sort!{ |a,b| a[12] <=> b[12] } 
 
 @commspref.each do |row|
    row.delete_at(12) 
 end
  
  @members  = @person.member.people.map do |person|
    [
        person.first_name,
        person.last_name,
        person.DOB.to_s ,
        person.mobile_phone ,
        person.occupation || 'Occupation',
        person.status_name,
       sort = case person.status_name
            when 'Main Member' then 1
            when 'Partner' then 2
            when 'Cadet' then 3
            when 'Parent' then 4
        end  
    ]
    end
@memberloyalty  = @person.member.people.map do |person|
    
    [   
            person.status == 'g' ? '' : person.first_name ,
            person.status == 'g' ? '' : number_to_euro((person.loyaltycard.Current_Points ).to_f / 100  )       
    ]
    

end

 @members = @members.sort!{ |a,b| a[6] <=> b[6] } 
 
 @members.each do |row|
    row.delete_at(6) 
 end
 
 
    fieldnamebgcolor = '909090'
    fielvaluebgcolor = 'E9E9E9'
    txtcolor = '000000'
    
#if @person.member.boats.count > 0 
   @boats  = @person.member.boats.map do |boat|
    
     [
         boat.boat_name.blank? ? 'Boat Name': boat.boat_name ,
         boat.boat_type.blank?   ? '       ': boat.boat_type,
         boat.boat_class.blank?   ? '      ': boat.boat_class,     
         boat.sail_number.blank?   ? '     ': boat.sail_number,    
         boat.pen_tag.blank?   ? '         ': boat.pen_tag
    ]

    
    end
    
    num_dinghies = @person.member.boats.dinghy.count

    num_boats = @boats.size
    
    2.times do 
            @boats << [ 'Boat Name' ,'Boat Type','Boat Class','sail Number','Pen tag (Dinghy)' ]
          
    end
    
  
   @address =[[]]
    
   @address = 
      
           [ 'House Name or Number:' ,@member.name_no.blank?     ? 'House Name/No'  : @member.name_no , 'City:'                ,@member.city.blank?        ? ''           : @member.city   ],
           [ 'Street1:'              ,@member.street1.blank?     ? ''       : @member.street1         ,'County:'              ,@member.county.blank?      ? ''         : @member.county   ],
           [ 'Street2:'              ,@member.street2.blank?     ? ''       : @member.street2         , 'Country:'             ,@member.country.blank?     ? ''        : @member.country    ],
           [  'Town:'                ,@member.town.blank?        ? ''           : @member.town  , 'Post Code:'           ,@member.postcode.blank?    ? ''       : @member.postcode       ],
           
         
           [ 'Home Phone:'           ,@person.home_phone.blank?  ? 'e.g. 353 x xxx xxxx'     : @person.home_phone  ]
       
  
 
    @post_address = [
       [  @person.salutation ],
       [  @member.name_no.blank?         ? ' ' : @member.name_no            ] ,
       [  @member.street1.blank?         ? ' ' : @member.street1           ] ,
       [  @member.street2.blank?         ? ' ' : @member.street2           ] ,
       [  @member.town.blank?            ? ' ' : @member.town              ] ,
       [  @member.city.blank? || @member.city == @member.county ? ' ' : @member.city              ] ,
       [  @member.county.blank?          ? ' ' : @member.county + ' ' +  (@member.postcode.blank? ? ' ' : @member.postcode )           ] ,
       [  @member.country.blank? ||@member.country == 'Ireland'  ? ' ' : @member.country    ] ,
       ]
     

@postal_address = @post_address.compact

@pad =[[]]

@postal_address.each do | address_line |

       if address_line != [' '] 
          @pad << address_line
       end
       end


    @cart = []
    cart_totals = []
    cart_total = 0
    @cart << [ 'Description',  ' ',  ' ',  ' ',  ' ' ]
    
    @cart << ["#{@person.member.privilege.class_desc } Membership Renewal", " " ," " ," = ","#{number_to_euro(@person.member.privilege.subscriptions.thisyear(@person.member.privilege.id)[0].amount ) }"  ] 
    
    cart_totals << [@person.member.privilege.subscriptions.thisyear(@person.member.privilege.id)[0].amount]
    
    if num_dinghies > 0 
        @cart << ["Pen Fees first Dinghy", "1","#{number_to_euro(20)}"," = ", "#{number_to_euro(20)}"]
    cart_totals << [20]    
    end
    if num_dinghies > 1   ###  NEED to remove the Cruisers from the pen fees count !!! ######
          
            @cart << ["Pen Fees additional Dinghy", "#{(num_dinghies -1)}","#{number_to_euro(5)}","  ", "#{number_to_euro(5 * (num_dinghies -1 ))}"]
            cart_totals << [(num_dinghies -1) * 5 ]    
        
    end
    
    cart_sum = eval cart_totals.join('+')
    @cart << ["Total"," ", " ", "  ", "#{number_to_euro(cart_sum) }" ] 
        
        
        
        
        
        
        
        
        
        


##################         Start of document.  ##########################################


full_width = 525


# encrypt_document 
#    pdf.encrypt_document :permissions => { :print_document => true },
#                   :user_password => 'test'
    





######## Header ?? #######






#pdf.move_down(10)



#########    MYC_ADDRESS    ##############

  
top = pdf.cursor

pdf.bounding_box([450,top], :width => 100) do (
pdf.move_down(10)
   logo = 'public/images/MYC.jpg'
   pdf.image(logo, :at => [0,pdf.cursor],:height => 80, :position => :center, :border => 2)
   pdf.move_down(80)
   
  # pdf.text "Malahide Yacht Club" ,:size => 10, :style => :bold,:horizontal_padding => 10
   pdf.text "St. James Terrace" ,:size => 10, :style => :normal,:horizontal_padding => 2
   pdf.text "Malahide" ,:size => 10, :style => :normal,:horizontal_padding => 2
   pdf.text "Co. Dublin" ,:size => 10, :style => :normal,:horizontal_padding => 2
   pdf.text "Phone: 353 (0)1 8453372" ,:size => 8, :style => :normal,:horizontal_padding => 2
   pdf.text "www.myc.ie" ,:size => 8, :style => :normal,:horizontal_padding => 2
   pdf.text "#{Time.now}" ,:size => 8, :style => :normal,:horizontal_padding => 2
  
   
   
   ) 
   end

   pdf.move_down(20) 
   column1_end = pdf.cursor



pdf.font "Times-Roman"         , :size => 10

##########  POSTAL ADDRESS  #######################

pdf.bounding_box([30,top], :width => (full_width - 110) ) do (
    pdf.move_down(60)
    
    pdf.text " "     
      
    pdf.table(@pad, :column_widths => {0 => 240 } ,
                    :cell_style => {:padding => 0 ,:border_width => 0 , 
                                    :borders => [:right,:left,:top,:bottom]
                                   }
                    ) do |t| 
                     t.column(0).style :size => 12
                    end
                      
    )
    end
    
    

pdf.move_down(10)

#FORM_START
pdf.bounding_box([000,pdf.cursor], :width => (full_width ) ) do (
    pdf.move_down(5)    
      
    pdf.text " Dear #{@person.salutation_first_names },  
    
    Please complete and return the #{@person.member.privilege.class_desc }  Membership Renewal Form overleaf with your subscription at your earliest convenience. An early response from members greatly assists the Club's financial position especially in these challenging times. A €40 bar credit will apply to all Family memberships, €20 to Ordinary and Senior memberships and  €10 to Pavilion memberships renewed in full by 31st January 2011. Please note that this credit will expire if unused by 30 September 2011. " ,:size => 10, :style => :normal, :align => :justify

    pdf.move_down(2)
    pdf.text " Again this year in consideration of many people's changing circumstances it is proposed to allow Ordinary and Family members to pay their subscriptions in two separate instalments, one half by 31 January and the balance by 30 April 2011 but a bar credit does not apply in this circumstance. ",:size => 10, :style => :normal, :align => :justify

     pdf.move_down(2)
     pdf.text "2011 Parking Permits for St. James's Terrace carpark will be issued to all paid up Ordinary, Family and Senior members at the end of January but please allow a minimum of seven days for your renewal to be processed. Seasonal Dinghy Pen Fees of €20 for the first boat stored and €5 for each subsequent boat have also been included on your renewal form to ease administration. Boat stickers will be issued and should be attached to all dinghies before the start of the sailing season.",:size => 10, :style => :normal, :align => :justify
    pdf.move_down(2)
    pdf.text "Any Family or Ordinary member wishing to transfer to senior membership should, if they satisfy the requirements of Rule 4 of the clubs constitution, complete an application form available from the website www.myc.ie or James Terrace clubhouse and return it with this renewal.",:size => 10, :style => :normal, :align => :justify
    pdf.move_down(2)
    pdf.text "Your renewal form has been completed with details from the club's database. Please check these details and amend if necessary prior to returning your form please pay particular attention to phone numbers and email addresses. All cadet members should also include their date of birth and if over 18 should include the name of the educational establishment at which they are FULL TIME students.", :size=> 10, :style => :normal , :align => :justify
    pdf.move_down(2)
    pdf.text "Please make full use of the section relating to club messages. You will see that it is possible to send separate messages to partners or children. Until the end of March messages will continue to be sent to all members on the 2010 membership list, however from the beginning of April messages will only be sent to members who have paid their 2011 subscriptions. Many members have elected to receive their renewal form by email this year thereby reducing the costs involved. If you wish to do the same please tick the relevant box at the end of the communications section.",:size => 10, :style => :normal, :align => :justify
    pdf.move_down(7)
    pdf.text "With best wishes for an enjoyable sailing season in 2011. " ,:size => 10, :style => :normal, :align => :justify
    sig = 'public/images/DMS.png'
    pdf.image(sig, :at => [0,pdf.cursor],:height => 25, :position => :center, :border => 2)
   pdf.move_down(25)
    pdf.text "Deirdre Moore Somers " ,:size => 10, :style => :normal, :align => :justify
    pdf.text "Hon Membership Secretary                                                                Email: membership.myc@gmail.com  " ,:size => 10, :style => :normal, :align => :justify
    #

    #pdf.stroke_bounds

    )
end
pdf.move_down(10)

###########       Member_Address        ####################

next_col = pdf.cursor

pdf.bounding_box([000,pdf.cursor], :width => 450 ) do (

    pdf.move_down(10)
    pdf.text "Member Home Address" ,:size => 14, :style => :bold,:horizontal_padding => 2

    
    pdf.table(@address, :column_widths => {0 => 100, 1=> 120, 2 => 100, 3 => 120 } ,
            :cell_style => {:border_width => 1 , 
                            :borders => []
                            #:borders => [:right,:left,:top,:bottom] 
                            }   
             ) do |t| 
              t.column(0).style :background_color => '000000', :text_color => 'ffffff'
              t.column(2).style :background_color => '000000', :text_color => 'ffffff'
              t.column(1).style  :text_color => entry_fields_txt_colour
              t.column(3).style  :text_color => entry_fields_txt_colour
             
             #t.row(0..9).style :borders => [:right,:left,:top,:bottom]
    end
    

    pdf.stroke_bounds

    )
end



pdf.start_new_page

########################  Membership Information ################################

pdf.bounding_box([000,pdf.cursor], :width => full_width ) do (
pdf.move_down(10)
    pdf.text "Membership information" ,:size => 14, :style => :bold,:horizontal_padding => 2

    pdf.move_down(5)    
   
    pdf.text "Please check that all members data here is correct." ,:size => 8, :style => :italic,:horizontal_padding => 2
    pdf.text "We require Date of birth for Cadet members. It can be an advantage when applying for funding to be able to give an acurate age profile of club members so if you wish, please also give dates of birth for all members. " +
     "Please state school/College name for Cadet Members as occupation.",:size => 8, :style => :italic,:horizontal_padding => 2
    
    header = ["First Name","Last Name","Date of birth \n yyyy-mm-dd","Mobile","Occupation","Status"] 
    header2 = ["First Name","Last Name","yyyy-mm-dd","Mobile","Occupation","Status"] 
     
    if @person.member.privilege.id == 2 ||  @person.member.privilege.id == 4 then
  
     
        #header = ["First Name","Last Name","Date of birth \n yyyy-mm-dd","Mobile","Occupation","Status"] 
        pdf.table( [header] + @members + [header2] , :header => :true,
        :cell_style => {:padding => 1, :borders => [] }, 
        #:borders => [:left, :right, :top, :bottom ] },
        :column_widths => {0 => 120, 1=> 120 , 2=> 60, 3 => 80, 4 => 80, 5 => 60 } ) do |t| 
         t.row(0).style :background_color => '000000', :text_color => 'ffffff'
         t.cells.row((1)..(t.row_length - 1 )).background_color = entry_fields_background_colour
         t.cells.row((1)..(t.row_length - 1 )).text_color = entry_fields_txt_colour
         t.cells.row((t.row_length - 1)..(t.row_length)).background_color = new_entry_fields_background_colour
         t.cells.row((t.row_length - 1)..(t.row_length)).text_color = new_entry_fields_txt_colour   
        end

    else 
         #header = ["First Name","Last Name","Date of birth \n yyyy-mm-dd","Mobile","Occupation","Status"] 
         pdf.table( [header] + @members , :header => :true,
        :cell_style => {:padding => 1, 
        #:borders => [:left, :right, :top, :bottom ]
        :borders => []
         },
        :column_widths => {0 => 120, 1=> 120 , 2=> 60, 3 => 80, 4 => 80, 5 => 60 } ) do |t| 
         t.row(0).style :background_color => '000000', :text_color => 'ffffff'
         t.cells.row(1).background_color = entry_fields_background_colour
         t.cells.row(1).text_color = entry_fields_txt_colour
        # t.cells.row((t.row_length - 2)..(t.row_length)).background_color = new_entry_fields_background_colour
        # t.cells.row((t.row_length - 2)..(t.row_length)).text_color = new_entry_fields_txt_colour   
        end

    end #if 
    





     pdf.stroke_bounds
  ) 
end

pdf.move_down(20)     


#################### COMMUNICATIONS ######################################
pdf.bounding_box([000,pdf.cursor], :width => full_width ) do (


pdf.move_down(10)
pdf.text "Communication Preferences" ,:size => 14, :style => :bold

pdf.text "Help MYC to reduce costs by only selecting to receive TXT messages where you " +
     "really require them. Emails cost nothing to MYC.",:size => 8, :style => :italic,:horizontal_padding => 2
    

    pdf.move_down(10)
    x = 360
    y = pdf.cursor  - 30 
    offset = 15
    rotate = 50 
    
    header = ["First","email","Send \nTxt","Send \nEmail"] 
    header2 = ["First","email"," "," "," "," "," "," "," "," "," "," "] 
    pdf.draw_text "Social", :at => [x += offset ,y], :size => 8, :rotate => rotate
    pdf.draw_text "Cruiser Racing", :at => [x += offset ,y], :size => 8, :rotate => rotate
    pdf.draw_text "Cruiser Race Skipper", :at => [x += offset ,y], :size => 8, :rotate => rotate
    pdf.draw_text "Cruising", :at => [x += offset ,y], :size => 8, :rotate => rotate
    pdf.draw_text "Cruising Skipper", :at => [x += offset ,y], :size => 8, :rotate => rotate
    pdf.draw_text "Dinghy Sailing", :at => [x += offset ,y], :size => 8, :rotate => rotate
    pdf.draw_text "Junior Sailing", :at => [x += offset ,y], :size => 8, :rotate => rotate
    pdf.draw_text "Optimist Coaching", :at => [x += offset ,y], :size => 8, :rotate => rotate
    
    
 if @person.member.privilege.id == 2 ||  @person.member.privilege.id == 4 then
 
        pdf.table([header] +  @commspref + [header2]  ,
        :cell_style => { :padding => 4, 
        :borders => [:left, :right, :top, :bottom ]
        #:borders => []
        },
        :column_widths => {0 => 100, 1=> 200 , 2=> 30, 3 => 35, 4 => 15, 5 => 15, 6 => 15, 7 => 15, 8 => 15, 9 => 15, 10 => 15, 11 => 15, 12 => 15 } 
        ) do |t|
        t.row(0).style :background_color => '000000', :text_color => 'ffffff'        
        #t.row(0).column(4).style :style => :bold, :rotate => 50
         t.cells.row((1)..(t.row_length - 1 )).background_color = entry_fields_background_colour
         t.cells.row((1)..(t.row_length - 1 )).text_color = entry_fields_txt_colour
         t.cells.row((t.row_length - 1)..(t.row_length)).background_color = new_entry_fields_background_colour
         t.cells.row((t.row_length - 1)..(t.row_length)).text_color = new_entry_fields_txt_colour
         end
  
  else 
        
        pdf.table([header] +  @commspref  ,
        :cell_style => { :padding => 4, 
        :borders => [:left, :right, :top, :bottom ]
        #:borders => []
        },
        :column_widths => {0 => 100, 1=> 200 , 2=> 30, 3 => 35, 4 => 15, 5 => 15, 6 => 15, 7 => 15, 8 => 15, 9 => 15, 10 => 15, 11 => 15, 12 => 15 } 
        ) do |t|
        t.row(0).style :background_color => '000000', :text_color => 'ffffff'        
        #t.row(0).column(4).style :style => :bold, :rotate => 50
        t.cells.row(1).background_color = entry_fields_background_colour
        t.cells.row(1).text_color = entry_fields_txt_colour
        
        #for pavillion - only Social.. 
        #t.cells.row(1).column(5..(t.column_length)).style :borders => [ ]
        #t.cells.row(1).column(5).style :borders => [:left]
        #t.cells.row((t.row_length - 2)..(t.row_length)).text_color = new_entry_fields_txt_colour
        end
  
  end #if

pdf.move_down(5)   
pdf.text "If you would prefer to receive your next renewal notice by Email, then please tick this box.  |_| ", :size => 10, :style => :normal,:horizontal_padding => 2
pdf.move_down(5) 
     
pdf.stroke_bounds
) end   

pdf.move_down(20)


############   boats ##################


if @person.member.privilege.boat_storage == 1  then
( 
 #pdf.start_new_page

pdf.bounding_box([000,pdf.cursor], :width => full_width ) do (
pdf.move_down(10)
 pdf.text  "Boats" ,:size => 16, :style => :bold
 pdf.text "You have #{num_boats} boat(s) registered ", :size => 10, :style => :normal,:horizontal_padding => 2
 
    header = ["Boat Name","Boat Type \n Cruiser/Dinghy/Motor","Boat Class","Sail Number","Pen Tag \n (Dinghies Only)"]
 
   pdf.table([header] + @boats,options={:header => true, :column_widths => {0 => 100, 1=> 100, 2=> 100, 3 => 80, 4 => 80 }} ) do |t|
        t.column(2).style :align => :right
        t.column(4).style :align => :right
        t.row(0).style :background_color => '000000', :text_color => 'ffffff'
        #t.cells.style :borders => [:left, :right, :top, :bottom]
        t.cells.style :borders => []
        t.cells.row((1)..(@boats.length - 2 )).background_color = entry_fields_background_colour
        t.cells.row((1)..(@boats.length - 2 )).text_color = entry_fields_txt_colour
        t.cells.row((@boats.length - 1)..(@boats.length )).background_color = new_entry_fields_background_colour
        t.cells.row((@boats.length - 1)..(@boats.length )).text_color = new_entry_fields_txt_colour
        #t.row(t.row_length).column(0).style :borders => []
        
   end
    
  ) 
  pdf.stroke_bounds  
end

pdf.start_new_page
)end


      

top_subs = pdf.cursor 

pdf.bounding_box([000,pdf.cursor], :width => 300 ) do (
pdf.text  "Subscriptions" ,:size => 14, :style => :bold
 pdf.text " ", :size => 10, :style => :normal,:horizontal_padding => 2

          
   pdf.table(@cart) do |t| 
        t.column(2).style :align => :right
        t.column(4).style :align => :right
        t.row(0).style :background_color => '000000', :text_color => 'ffffff'
        t.cells.style :borders => []
        t.column(4).row(@cart.length - 1).style :borders => [:top] 
        t.column(4).row(@cart.length - 1).style :style => :bold, :rotate => 0
        t.cells.row(@cart.length - 1 ).background_color = new_entry_fields_background_colour
        
   end
    pdf.stroke_bounds   
)
end

if ( (@person.loyaltycard.Current_Points).to_f > 0 and (@person.loyaltycard.RedeemedTD).to_f < 11 )  

pdf.bounding_box([310,top_subs ], :width => 200,:padding => 1) do (

    pdf.move_down(3)
    pdf.text "You haven't used your barcard for some time, here is the balance available to spend",:size => 8, :style => :italic,:horizontal_padding => 2
    #pdf.font "Times-Roman"         , :size => 10
    #pdf.text "Barcard Balance"         #:size => 10, :style => :normal
    
   # header = ["First Name", "Balance"]
    pdf.table(  @memberloyalty , :header => :true ,
    :cell_style => {:padding => 4, :borders => [], :border_width => 1 } 
    ) do
        #style column(0), :border_width => 1#, :borders => [:right,:left,:top]
        #style row(0), :border_width => 1#, :borders => [:right,:left,:top]
    end
    #pdf.stroke_bounds
    )
end
end

pdf.move_down(60) 

 
 payment = 'public/images/payment.png'
    pdf.image(payment, :at => [0,pdf.cursor],:height => 350, :position => :center, :border => 2)
   pdf.move_down(350)

     
      
      
   pdf.text "Please complete and return this form with all required signatures and the appropriate fee to the Membership Secretary, MYC. Acknowledgement of receipt of your application will be sent if you have provided a valid email address.", 
        :size => 8, :style => :bold, :align => :center   
########    Number Pages    ##########


pdf.number_pages "Page <page> of <total>, MYC Renewal #{Time.now.year}, #{@person.first_name + ' ' + @person.last_name}", [(pdf.bounds.right - pdf.bounds.left - 100 ) / 2 , 0]


pdf.render_file("#{@person.last_name}#{@person.first_name}.pdf")
      
      
      
