class UserMailer < ActionMailer::Base
  default from: "omkar.b440@gmail.com"
  def invite_user(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end
end
