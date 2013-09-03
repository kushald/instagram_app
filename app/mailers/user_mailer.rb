class UserMailer < ActionMailer::Base
  default from: "joyviewer@gmail.com"

  def send_mail(user)
    mail(:to => "kushz19@gmail.com", :subject => "Hi")
  end

  def experror(e, request)
    @err=e
    @request = request
    mail(:to => "kushz19@gmail.com",
    :subject => e.message)
  end

end
