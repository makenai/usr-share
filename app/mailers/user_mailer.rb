class UserMailer < ActionMailer::Base

  default from: "hal9000@usrlib.org"
  
  def pickup_email(user)
    @user = user
    mail( :to => user.email, :subject => "Your /usr/lib card is ready!", :bcc => 'pickup@usrlib.org' )
  end
  
end
