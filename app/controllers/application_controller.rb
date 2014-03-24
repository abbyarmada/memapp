# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base
  
  
 # for testing acts_as_iphone_controller(false)
 
  helper :all # include all helpers, all the time
 
before_filter :detect_iphone_request


def call_rake(task, options = {})
  puts "Running rake...!"
  options[:rails_env] ||= Rails.env
  args = options.map { |n, v| "#{n.to_s.upcase}='#{v}'" }
  #if RbConfig::CONFIG['target_os'] = 'mingw32' 
  #   system " start C:\\Ruby193\\bin\\rake #{task} #{args.join(' ')} >> #{Rails.root}/log/rake.log 2>&1 &"
  # else
     system "rake #{task} #{args.join(' ')}  >> #{Rails.root}/log/rake.log 2>&1 &" 
  #end
end

#  --rakefile #{Rails.root}/Rakefile 


#def call_rake(task, options = {})
#  puts "Calling Rake " + Time.now.to_s 
#  options[:rails_env] ||= Rails.env
#  args = options.map { |n, v| "#{n.to_s.upcase}='#{v}'" }
#  if RbConfig::CONFIG['target_os'] = 'mingw32' 
#    system " start C:\\Ruby193\\bin\\rake #{task} #{args.join(' ')} --trace  2>&1 >> #{Rails.root}/log/rake.log "
#  else 
#    system "rake #{task} #{args.join(' ')} --trace 2>&1 >> #{Rails.root}/log/rake.log &"
#  end
#end

  protected
  def detect_iphone_request
 #   request.format = :iphone if iphone_request?
  end

  def iphone_request?
  # request.env["HTTP_USER_AGENT"] &&
     # request.env["HTTP_USER_AGENT"][/(Mobile\/.+Safari)/]
   #   request.env["HTTP_USER_AGENT"][/iPhone/]
  end

  # ...

before_filter :jumpback
protected
  def jumpback
    session[:jumpback] = session[:jumpcurrent] unless session[:jumpback] == session[:jumpcurrent]
    session[:jumpcurrent] = request.fullpath
  end  

 def rescue_action_in_public(exception)
    case exception
     when ::ActionController::RedirectBackError
       jumpto = session[:jumpback] || {:controller => "people"}
       redirect_to jumpto
     else
       super
     end
  end















end

