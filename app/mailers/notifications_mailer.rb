class NotificationsMailer < ActionMailer::Base
  default from: "Confiz HRM <confizhrmdev@gmail.com>"

  def company_signup_notification(company)
    @host = $site_url
    @company = company
    
    mail to: @company.email, subject: "Company Signup Notification"
  end
end
