# -*- coding: utf-8 -*-
# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # Request from an iPhone or iPod touch? (Mobile Safari user agent)
def iphone_user_agent?
  request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"][/(Mobile\/.+Safari)/]
end


  def number_to_euro(item)
      number_to_currency(item, :unit => "€", :separator => ".", :delimiter => ",", :format => "%n %u")
  end




end


