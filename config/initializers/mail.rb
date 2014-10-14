ActionMailer::Base.smtp_settings = {
      :address => ENV['MAIL_HOST'],
      :port => 25,
      # :domain => "xxxx.com",
      :user_name => ENV['MAIL_USERNAME'],
      :password => ENV['MAIL_PASSWORD'],
      :authentication => :plain,
      :enable_starttls_auto => true,
      :openssl_verify_mode  => 'none' 
}
