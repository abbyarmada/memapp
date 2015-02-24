# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  protect_from_forgery
  helper :all # include all helpers, all the time

  def call_rake(task, options = {})
    puts "Running rake...!"
    options[:rails_env] ||= Rails.env
    args = options.map { |n, v| "#{n.to_s.upcase}='#{v}'" }
    system "rake #{task} #{args.join(' ')} & "
  end


  protected

  before_filter :jumpback
  def jumpback
    session[:jumpback] = session[:jumpcurrent] unless session[:jumpback] == session[:jumpcurrent]
    session[:jumpcurrent] = request.fullpath
  end

end
