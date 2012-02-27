class ContactController < ApplicationController
  
  def show
    @contact = Contact.new()
    if current_user
      if current_user.member
        @contact.name = current_user.member.name
      else
        @contact.name = current_user.name
      end
      @contact.email = current_user.email
    end
  end
  
  def create
    @contact = Contact.new( params[:contact] )
    if @contact.valid?
      StaffMailer.contact_email( @contact, request ).deliver
      render :thankyou
    else
      render :show
    end
  end
  
  
end
