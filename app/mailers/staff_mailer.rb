class StaffMailer < ActionMailer::Base
  default from: "from@example.com"
  
  
  def contact_email(contact, request)
    @contact = contact
    @request = request
    mail( :to      => 'liboard@usrlib.org',
          :from    => @contact.email,
          :subject => "[CONTACT] Message from #{contact.name}" )
  end
  
  def event_email(event)
    return unless event.member
    @event = event
    mail( :to => 'liboard@usrlib.org', 
          :from => event.member.user.email, 
          :subject => "[EVENT] #{event.name} - #{event.start_time.strftime('%Y-%m-%d %l %p')}"
        )
  end
  
  
end
