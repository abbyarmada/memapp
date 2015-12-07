# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  protect_from_forgery  with: :exception
  helper :all # include all helpers, all the time
  after_filter :discard_flash_if_xhr

  def call_rake(task, options = {})
    #puts "Running rake...!"
    options[:rails_env] ||= Rails.env
    #Rails.env
    args = options.map { |n, v| "#{n.to_s.upcase}='#{v}'" }
    system("rake"," #{task} #{args.join(' ')} -trace 2>&1 >> #{Rails.root}/log/rake.log & ")
  end


  protected

  before_filter :jumpback
  def jumpback
    session[:jumpback] = session[:jumpcurrent] unless session[:jumpback] == session[:jumpcurrent]
    session[:jumpcurrent] = request.fullpath
  end

  def discard_flash_if_xhr
    flash.discard if request.xhr?
  end

end
