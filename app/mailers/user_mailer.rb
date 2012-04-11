class UserMailer < ActionMailer::Base

  default from: "hal9000@usrlib.org"
  
  def pickup_email(user)
    @user = user
    mail(
      :to => user.email,
      :subject => "Your /usr/lib card is ready!"
    )
  end
  
  def event_question_email(contact,event)
    @contact = contact
    @event = event
    mail(
      :to      => @event.member.user.email,
      :from    => @contact.email,
      :subject => "[USRLIB] Question about #{@event.name}",
      :bcc     => 'liboard@usrlib.org'
    )
  end
  
end
