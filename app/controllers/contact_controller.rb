class ContactController < ApplicationController
  
  def show
    @contact = Contact.new()
    fill_in_sender_information
  end
  
  def create
    @contact = Contact.new( params[:contact] )
    
    if @contact.event_id
    
      # An event contact
      @event = Event.find( @contact.event_id )
      fill_in_sender_information
      if @contact.valid?
        UserMailer.event_question_email( @contact, @event ).deliver
        redirect_to @event, :notice => 'Your question has been sent!'
      else
        render 'events/show'
      end
      
    else
      
      # A staff contact
      if @contact.valid?
        StaffMailer.contact_email( @contact, request ).deliver
        render :thankyou
      else
        render :show
      end
      
    end
  end
  
  private
  
  def fill_in_sender_information
    if current_user
      @contact.name = current_user.best_name
      @contact.email = current_user.email
    end
  end
  
end
