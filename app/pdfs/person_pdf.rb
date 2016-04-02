# encoding: utf-8
class PersonPdf < Prawn::Document
  include ActionView::Helpers::NumberHelper
  require 'prawn/table'
  def initialize(person)
    super(page_size: 'A4')
    # full_width = 525
    @person = person
    @member = @person.member
    @pbc = @person.peoplebarcard
    top = cursor
    bounding_box([420, top], width: 100) do
      move_down(01)
      logo
      move_down(80)
      address_txt
    end

    move_down(20)
    font 'Helvetica', size: 10
    ##########  POSTAL ADDRESS  #######################
    bounding_box([30, top], width: (full_width - 110)) do
      # move_down(60)
      table(pad, column_widths: { 0 => 240 }, cell_style: { padding: 0, border_width: 0, borders: [:right, :left, :top, :bottom] }) do |t|
        t.column(0).style size: 12
      end
    end
    move_down(50)

    # FORM_START
    bounding_box([000,cursor], width: (full_width ) ) do
      move_down(5)
      text " Dear #{@person.salutation_first_names },
      Please complete and return the #{@person.member.privilege.name } Membership Renewal Form overleaf with your subscription at your earliest convenience. An early response from members greatly assists the Club's financial position especially in these challenging times. A €30 bar credit will apply to all Family memberships, €20 to Ordinary memberships and  €10 to Pavilion and Senior memberships renewed in full by 31st January. Please note that this credit will expire if unused by 30 September this year. " ,size: 10, style: :normal, align: :justify
      move_down(1)
      text " Again this year in consideration of many people's changing circumstances it is proposed to allow Ordinary and Family members to pay their subscriptions in two separate installments, one half by 31 January and the balance by 30 April but a bar credit does not apply in this circumstance. ",size: 10, style: :normal, align: :justify

      move_down(1)
      text "Parking Permits for St. James's Terrace car park will be issued to all paid up Ordinary, Family and Senior members at the end of January but please allow a minimum of seven days for your renewal to be processed. Seasonal Dinghy Pen Fees have been included on your renewal form to ease administration. Boat stickers will be issued and should be attached to all dinghies before the start of the sailing season.",size: 10, style: :normal, align: :justify
      move_down(1)
      text "Any Family or Ordinary member wishing to transfer to senior membership should, if they satisfy the requirements of Rule 4 of the clubs constitution, complete an application form available from the website www.myc.ie or James Terrace clubhouse and return it with this renewal.",size: 10, style: :normal, align: :justify
      move_down(1)
      formatted_text([
        {text: "Your renewal form has been completed with details from the club's database. Please check these details and amend if necessary prior to returning your form " , size: 10, style: :normal , align: :justify },
        {text: "please pay particular attention to phone numbers and email addresses. ", size: 12, style: :bold , align: :justify },
        {text: "All cadet members should also include their date of birth and if over 18 should include the name of the educational establishment at which they are FULL TIME students.", size: 10, style: :normal , align: :justify }
      ])
      move_down(1)
      text "Please make full use of the section relating to club messages. You will see that it is possible to send separate messages to partners or children. Until the end of March messages will continue to be sent to all members on last years membership list, however from the beginning of April messages will only be sent to members who have paid this years subscriptions. Many members have elected to receive their renewal form by email this year thereby reducing the costs involved. If you wish to do the same please tick the relevant box at the end of the communications section.",size: 10, style: :normal, align: :justify
      move_down(1)
      text "With best wishes for an enjoyable sailing season, " ,size: 10, style: :normal, align: :justify

      move_down(25)
      text "Nigel Mc Keaney " ,size: 10, style: :normal, align: :justify
      text "Hon Membership Secretary                                                                Email: membership.myc@gmail.com  " ,size: 10, style: :normal, align: :justify
    end

    move_down(10)

    ###########       Member_Address        ####################

    bounding_box([000, cursor], width: 450) do
      move_down(5)
      text 'Member Home Address', size: 14, style: :bold, horizontal_padding: 2
      table(address, column_widths: { 0 => 100, 1 => 120, 2 => 100, 3 => 120 },
                     cell_style: { border_width: 1, borders: [] }) do |t|
        t.column(0).style background_color: 'ffffff', text_color: '000000'
        t.column(2).style background_color: 'ffffff', text_color: '000000'
        t.column(1).style  text_color: entry_fields_txt_colour
        t.column(3).style  text_color: entry_fields_txt_colour
      end
      stroke_bounds
    end
    start_new_page

    ########################  Membership Information ################################

    bounding_box([000, cursor], width: full_width) do
      move_down(4)
      text "Membership information" ,size: 14, style: :bold,horizontal_padding: 2
      move_down(1)
      text "Please check that all members data here is correct." ,size: 8, style: :italic,horizontal_padding: 2
      text "We require Date of birth for Cadet members. It can be an advantage when applying for funding to be able to give an acurate age profile of club members so if you wish, please also give dates of birth for all members. " \
       "Please state school/College name for Cadet Members as occupation.",size: 8, style: :italic,horizontal_padding: 2

      header = ['First Name', 'Last Name', "Date of birth \n yyyy-mm-dd", 'Mobile', 'Occupation', 'Status']
      header2 = [' ']
      if @person.member.privilege.id == 2 || @person.member.privilege.id == 4
        table([header] + members + [header2], header: :true,
                                              cell_style: { padding: 1, borders: [] },
                                              column_widths: { 0 => 120, 1 => 120, 2 => 60, 3 => 80, 4 => 80, 5 => 60 }) do |t|
          t.row(0).style background_color: 'ffffff', text_color: '000000'
          t.cells.row(1..(t.row_length - 1)).background_color = entry_fields_background_colour
          t.cells.row(1..(t.row_length - 1)).text_color = entry_fields_txt_colour
          t.cells.row((t.row_length - 1)..(t.row_length)).background_color = new_entry_fields_background_colour
          t.cells.row((t.row_length - 1)..(t.row_length)).text_color = new_entry_fields_txt_colour
        end
      else
        header = ['First Name', 'Last Name', "Date of birth \n yyyy-mm-dd", 'Mobile', 'Occupation']
        table([header] + members, header: :true,
                                  cell_style: { padding: 1, borders: [] },
                                  column_widths: { 0 => 120, 1 => 120, 2 => 60, 3 => 80, 4 => 80 }) do |t|
          t.row(0).style background_color: 'ffffff', text_color: '000000'
          t.cells.row(1).background_color = entry_fields_background_colour
          t.cells.row(1).text_color = entry_fields_txt_colour
        end
      end
      stroke_bounds
    end

    move_down(3)

    #################### COMMUNICATIONS ######################################
    bounding_box([000,cursor], width: full_width ) do (
      move_down(2)
      text "Communication Preferences" ,size: 14, style: :bold
      text "Help MYC to reduce costs by only selecting to receive TXT messages where you " \
         "really require them. Emails cost nothing to MYC.",size: 8, style: :italic,horizontal_padding: 2
      bounding_box([10, cursor], width: 300) do
        move_down(5)
        text "  If you would prefer to receive your next renewal notice by Email, then please tick this box. ", size: 8, style: :normal,horizontal_padding: 1
        bounding_box([050,cursor + 10 ], width: 20 ) do
          text ' '
          stroke_bounds
        end
        move_down(1)
        stroke_bounds
      end
      move_down(20)
      x = 365
      y = cursor - 30
      offset = 15
      rotate = 90

      header = ["First Name","email","Send \nTxt","Send \nEmail"]
      header2 = [" "," "," "," "," "," "," "," "," "," "," "," "]
      draw_text 'Social', at: [x += offset ,y], size: 8, rotate: rotate
      draw_text 'Cruiser Racing', at: [x += offset ,y], size: 8, rotate: rotate
      draw_text 'Cruiser Race Skipper', at: [x += offset ,y], size: 8, rotate: rotate
      draw_text 'Cruising', at: [x += offset ,y], size: 8, rotate: rotate
      draw_text 'Cruising Skipper', at: [x += offset ,y], size: 8, rotate: rotate
      draw_text 'Dinghy Sailing', at: [x += offset ,y], size: 8, rotate: rotate
      draw_text 'Junior Sailing', at: [x += offset ,y], size: 8, rotate: rotate
      draw_text 'Optimist Coaching', at: [x += offset ,y], size: 8, rotate: rotate

      if @person.member.privilege.id == 2 || @person.member.privilege.id == 4
        table([header] +  commspref + [header2],
              cell_style: { padding: 4,
                            borders: [:left, :right, :top, :bottom]
              },
              column_widths: { 0 => 100, 1 => 200, 2 => 35, 3 => 35, 4 => 15, 5 => 15, 6 => 15, 7 => 15, 8 => 15, 9 => 15, 10 => 15, 11 => 15, 12 => 15 }
             ) do |t|
          t.row(0).style background_color: 'ffffff', text_color: '000000'
          t.cells.row(1..(t.row_length - 1)).background_color = entry_fields_background_colour
          t.cells.row(1..(t.row_length - 1)).text_color = entry_fields_txt_colour
          t.cells.row((t.row_length - 1)..(t.row_length)).background_color = new_entry_fields_background_colour
          t.cells.row((t.row_length - 1)..(t.row_length)).text_color = new_entry_fields_txt_colour
        end

      else

        table([header] +  commspref,
              cell_style: { padding: 4,
                            borders: [:left, :top, :right, :bottom]
                #:borders => []
              },
              column_widths: { 0 => 100, 1 => 200, 2 => 35, 3 => 35, 4 => 15, 5 => 15, 6 => 15, 7 => 15, 8 => 15, 9 => 15, 10 => 15, 11 => 15, 12 => 15 }
             ) do |t|
          t.row(0).style background_color: 'FFFFFF', text_color: '000000'
          t.cells.row(1).background_color = entry_fields_background_colour
          t.cells.row(1).text_color = entry_fields_txt_colour
        end
     end

      move_down(5)

      stroke_bounds
    )
    end

    ############   boats ##################

    if @person.member.privilege.boat_storage == 1 then
      (
      # start_new_page

      bounding_box([000,cursor], width: full_width ) do
        (
      move_down(10)
      text 'Boats', size: 16, style: :bold
      text "You have #{num_boats} boat(s) registered ", size: 10, style: :normal,horizontal_padding: 2

      header = ["Boat Name","Boat Type ","Boat Class","Sail Number","Pen Tag"]

      table([header] + boats,options={header: true, column_widths: {0 => 100, 1=> 100, 2=> 100, 3 => 80, 4 => 80 }} ) do |t|
        t.column(2).style align: :right
        t.column(4).style align: :right
        t.row(0).style background_color: 'ffffff', text_color: '000000'
        # t.cells.style :borders => [:left, :right, :top, :bottom]
        t.cells.style borders: []
        t.cells.row((1)..(boats.length - 2 )).background_color = entry_fields_background_colour
        t.cells.row((1)..(boats.length - 2 )).text_color = entry_fields_txt_colour
        t.cells.row((boats.length - 1)..(boats.length )).background_color = new_entry_fields_background_colour
        t.cells.row((boats.length - 1)..(boats.length )).text_color = new_entry_fields_txt_colour
        # t.row(t.row_length).column(0).style :borders => []
      end

        )
        stroke_bounds
      end

      start_new_page
      )end

    move_down(5)
    top_subs = cursor

    bounding_box([000,cursor], width: 300 ) do (

      move_down(5)
      text "Subscriptions" ,size: 14, style: :bold
      table(cart) do |t|
        t.column(2).style align: :right,size: 8
        t.column(4).style align: :right,size: 8
        t.row(0).style background_color: 'ffffff', text_color: '000000'
        t.cells.style borders: [],size: 8
        t.column(4).row(cart.length - 1).style borders: [:top]
        # t.column(4).row(@cart.length - 1).style :style => :bold, :rotate => 0
        t.cells.row(cart.length - 1 ).background_color = new_entry_fields_background_colour
      end
      stroke_bounds
    )
    end

    if ( (@person.loyaltycard.Current_Points rescue 0 ).to_f > 0 && (@person.loyaltycard.RedeemedTD rescue 0 ).to_f < 11 ) && (1 == 0)
      bounding_box([310,top_subs ], width: 200,padding: 1) do (



        move_down(0)
        text "You haven't used your barcard for some time, here is the balance available to spend",size: 8, style: :italic,horizontal_padding: 2
        table( @memberloyalty , header: :true ,
                                cell_style: {padding: 4, borders: [], border_width: 1 }
             ) do
          # style column(0), :border_width => 1#, :borders => [:right,:left,:top]
          # style row(0), :border_width => 1#, :borders => [:right,:left,:top]
        end
      # stroke_bounds
      )
      end
    end

    move_down(2)
    payment = Rails.root + "app/assets/images/renewal.png"
    image(payment, at: [0,cursor],height: 350, position: :center, border: 2)
    move_down(350)

    text "Please complete and return this form with all required signatures and the appropriate fee to the Membership Secretary, MYC. Acknowledgement of receipt of your application will be sent if you have provided a valid email address.",
         size: 8, style: :bold, align: :center
    ########    Number Pages    ##########

    number_pages( "Page <page> of <total>, MYC Renewal #{Time.now.year}, #{@person.first_name + ' ' + @person.last_name}", options = {
                   at: [ bounds.right / 3 , 0],
                   width: 150,
                   align: :center,
                   page_filter: (1..7),
                   start_count_at: 1,
                   color: "007700" }
                )

    ## doc end.. init end...
  end

  def logo
    logo = Rails.root + "app/assets/images/MYCLogo2013.png"
    image(logo, at: [0,cursor],height: 80, position: :centre, border: 2)
  end

  def address_txt
    # text "Malahide Yacht Club" ,:size => 10, :style => :bold,:horizontal_padding => 10
    text "St. James Terrace" ,size: 10, style: :normal,horizontal_padding: 2
    text "Malahide" ,size: 10, style: :normal,horizontal_padding: 2
    text "Co. Dublin" ,size: 10, style: :normal,horizontal_padding: 2
    text "Phone: 353 (0)1 8453372" ,size: 8, style: :normal,horizontal_padding: 2
    text "www.myc.ie" ,size: 8, style: :normal,horizontal_padding: 2
    text "#{Time.now.to_date.to_s(:long)}" ,size: 8, style: :normal,horizontal_padding: 2
  end

  def first_name
    text "NAme: #{@person.first_name}"
  end

  def boats
    boats = []
    boats = @person.member.boats.map do |boat|
      [
        boat.boat_name.blank? ? 'Boat Name': boat.boat_name ,
        boat.boat_type.blank?   ? '       ': boat.boat_type,
        boat.boat_class.blank? ? '      ': boat.boat_class,
        boat.sail_number.blank? ? '     ': boat.sail_number,
        boat.pen_tag.blank?   ? '         ': boat.pen_tag
      ]
    end
    boats << [' ', ' ', ' ', ' ', ' ']
    boats << [' ', ' ', ' ', ' ', ' ']
  end

  def num_boats
    num_boats = boats.size - 2
  end

  def address
    address = [[]]
    address =
           [ 'House Name or Number:' ,@member.name_no.blank?     ? 'House Name/No'           : @member.name_no   , 'City:'            ,@member.city.blank?        ? ''       : @member.city     ],
           [ 'Street1:'              ,@member.street1.blank?     ? ''                        : @member.street1   , 'County:'          ,@member.county.blank?      ? ''       : @member.county   ],
           [ 'Street2:'              ,@member.street2.blank?     ? ''                        : @member.street2   , 'Country:'         ,@member.country.blank?     ? ''       : @member.country  ],
           [ 'Town:' ,@member.town.blank? ? '' : @member.town , 'Post Code:' ,@member.postcode.blank? ? '' : @member.postcode ],
           [ 'Home Phone:' ,@person.home_phone.blank? ? 'e.g. 353 x xxx xxxx' : @person.home_phone ]
    end

  def pad
    pad = [
      [  @person.salutation         ],
      [  @member.name_no            ] ,
      [  @member.street1            ] ,
      [  @member.street2            ] ,
      [  @member.town               ] ,
      [  @member.city.blank? || @member.city == @member.county ? '' : @member.city ] ,
      [  @member.county.blank?  ? '' + (@member.postcode.blank? ? '' : @member.postcode ) : @member.county + ' ' + (@member.postcode.blank? ? '' : @member.postcode ) ] ,
      [  @member.country.blank? || @member.country == 'Ireland' ? '' : @member.country ] ,
    ]
    pad.compact
    end

  ###########  CART ##############################

  def cart
    cart = []
    cart_totals = []
    cart_total = 0
    cart << [ 'Description', ' ', ' ', ' ',  ' ' ]
    cart << ["#{@person.member.privilege.name } Membership Renewal", " " ," " ," = ","#{number_to_euro(@person.member.privilege.subscriptions.thisyear(@person.member.privilege.id)) }" ]
    cart_totals << [@person.member.privilege.subscriptions.thisyear(@person.member.privilege.id)]

    if num_pentags > 0
      @person.member.boats.windsurfer.other.each do |penboats|
        cart << ["Pen Fees ", "#{penboats.boat_type}","#{penboats.boat_class}"," = ", "#{number_to_euro(40)}"]
        cart_totals << [40]
      end
      @person.member.boats.windsurfer.kona.each do |penboats|
        cart << ["Pen Fees ", "#{penboats.boat_type}","#{penboats.boat_class}"," = ", "#{number_to_euro(60)}"]
        cart_totals << [60]
      end

      @person.member.boats.dinghy.other.each do |penboats|
        cart << ["Pen Fees ", "#{penboats.boat_type}","#{penboats.boat_class}"," = ", "#{number_to_euro(60)}"]
        cart_totals << [60]
      end
      @person.member.boats.dinghy.topaz.each do |penboats|
        cart << ["Pen Fees ", "#{penboats.boat_type}","#{penboats.boat_class}"," = ", "#{number_to_euro(40)}"]
        cart_totals << [40]
      end
      @person.member.boats.dinghy.laser.each do |penboats|
        cart << ["Pen Fees ", "#{penboats.boat_type}","#{penboats.boat_class}"," = ", "#{number_to_euro(50)}"]
        cart_totals << [50]
      end
      @person.member.boats.dinghy.oppi.each do |penboats|
        cart << ["Pen Fees ", "#{penboats.boat_type}","#{penboats.boat_class}"," = ", "#{number_to_euro(30)}"]
        cart_totals << [30]
      end
      @person.member.boats.dinghy.canoe.each do |penboats|
        cart << ["Pen Fees ",
                 "#{penboats.boat_type}",
                 "#{penboats.boat_class}",
                 " = ",
                 "#{number_to_euro(00)}"]
        cart_totals << [00]
      end

  end

    cart_sum = eval cart_totals.join('+')
    cart << ["Total"," ", " ", "  ", "#{number_to_euro(cart_sum) }" ]
  end

  ################     end CART   ########################

  def members
    members = []

    if @person.member.people.count > 1
      members = @person.member.people.map do |person|
        [
          person.first_name,
          person.last_name,
          person.dob.to_s ,
          person.mobile_phone ,
          person.occupation || 'Occupation',
          person.status_name ,
          sort = case person.status_name
                 when 'Main Member' then 1
                 when 'Partner' then 2
                 when 'Cadet' then 3
                 when 'Parent' then 4
              end
        ]
      end
      members = members.sort!{ |a,b| a[6] <=> b[6] }
      members.each do |row|
        row.delete_at(6)
      end

    else
      members = @person.member.people.map do |person|
        [
          person.first_name,
          person.last_name,
          person.dob.to_s ,
          person.mobile_phone ,
          person.occupation || 'Occupation',

          sort = case person.status_name
                 when 'Main Member' then 1
                 when 'Partner' then 2
                 when 'Cadet' then 3
                 when 'Parent' then 4
              end
        ]
      end

      members = members.sort!{ |a,b| a[5] <=> b[5] }
      members.each do |row|
        row.delete_at(5)
      end

   end
   end

  def memberloyalty
    memberloyalty = @person.member.people.map do |person|
      [
        person.status == 'g' ? '' : person.first_name ,
        person.status == 'g' ? '' : number_to_euro((person.loyaltycard.Current_Points rescue 0 ).to_f / 100 )
      ]
    end
  end

  def commspref
    commspref = @person.member.people.map do |person|
      [
        person.first_name,
        person.email_address,
        person.send_txt ? 'Y': 'N',
        person.send_email? ? 'Y': 'N',
        person.txt_social.zero? ? ' ': 'Y',
        person.txt_crace.zero? ? ' ': 'Y',
        person.txt_cruiser_race_skipper.zero? ? ' ': 'Y',
        person.txt_cruising.zero? ? ' ': 'Y',
        person.txt_cruiser_skipper.zero? ? ' ': 'Y',
        person.txt_dinghy_sailing.zero? ? ' ': 'Y',
        person.txt_junior.zero? ? ' ': 'Y' ,
        person.txt_op_co.zero? ? ' ': 'Y' ,
        sort = case person.status_name
               when 'Main Member' then 1
               when 'Partner' then 2
               when 'Cadet' then 3
               when 'Parent' then 4
        end

      ]
    end

    commspref = commspref.sort!{ |a,b| a[12] <=> b[12] }

    commspref.each do |row|
      row.delete_at(12)
    end
  end

  def num_pentags
    @person.member.boats.penboats.count
  end

  def full_width
    525
   end

  def new_entry_fields_background_colour
    'ffffff'
  end

  def new_entry_fields_txt_colour
    '000000'
  end

  def entry_fields_background_colour
    'ffffff'
  end

  def entry_fields_txt_colour
    '888888'
  end

  def number_to_euro(item)
    number_to_currency(item, unit: '€', separator: '.', delimiter: ',', format: "%n %u")
  end
end
