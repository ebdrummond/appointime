# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Appointime::Application.initialize!

ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: 587,
  domain: "newleafmassage.net",
  authentication: "plain",
  enable_starttls_auto: true,
  user_name: "newleafmassage1@gmail.com",
  password: "megapeters"
}