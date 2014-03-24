  pdf.draw_text "a stroked rounded rectangle:", :at => [30, 575]
         
         
         
         pdf.stroke_rounded_rectangle([50, 550], 500, 300, 10) 
         
         
         #  pdf.line pdf.bounds.top_left
         
         pdf.cell [0,0], 
    :text => "Address",:size => 8,
    :border_style => :no_top, # :all, :no_bottom, :sides
    :horizontal_padding => 5,:width => 100, :height => 400

pdf.cell [100,400], 
    :text => "House Name or Number",:size => 12,
    :border_style => :no_top, # :all, :no_bottom, :sides
    :horizontal_padding => 5,:width => 100

pdf.cell [100,360], 
    :text => "#{@person.member.street1} ",:size => 12,
    :border_style => :no_top, # :all, :no_bottom, :sides
    :horizontal_padding => 5,:width => 100
        
pdf.cell [100,320], 
    :text => "#{@person.member.street2} ",:size => 12,
    :border_style => :no_top, # :all, :no_bottom, :sides
    :horizontal_padding => 5,:width => 100    
    
pdf.cell [100,280], 
    :text => "#{@person.member.town} ",:size => 12,
    :border_style => :no_top, # :all, :no_bottom, :sides
    :horizontal_padding => 5,:width => 100        
    
pdf.cell [100,240], 
    :text => "#{@person.member.city} ",:size => 12,
    :border_style => :no_top, # :all, :no_bottom, :sides
    :horizontal_padding => 5,:width => 100 

pdf.cell [100,200], 
    :text => "#{@person.member.county} ",:size => 12,
    :border_style => :no_top, # :all, :no_bottom, :sides
    :horizontal_padding => 5,:width => 100    
pdf.cell [100,160], 
    :text => "#{@person.member.country} ",:size => 12,
    :border_style => :no_top, # :all, :no_bottom, :sides
    :horizontal_padding => 5,:width => 100         
    
pdf.cell [100,120], 
    :text => "#{@person.member.postcode} ",:size => 12,
    :border_style => :no_top, # :all, :no_bottom, :sides
    :horizontal_padding => 5,:width => 100    