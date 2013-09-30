class NotificationsMailer < ActionMailer::Base
  default from: "Confiz HRM <confizhrmdev@gmail.com>"

  def company_signup_notification(company)
    @host = $site_url
    @company = company
    
    mail to: @company.email, subject: "Company Signup Notification"
  end

  def employee_signup_notification(employee)
    @host = $site_url
    @employee = employee
    
    mail to: @employee.email, subject: "Employee Signup Notification"
  end

end
