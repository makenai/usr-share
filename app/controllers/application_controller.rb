class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # authenticate_user! - provided by devise
  
  def authenticate_member!
    return if current_user.try(:member?)
    redirect_to :new_member, :notice => 'You must be a member to access that page.'
  end
  
  def authenticate_admin!
    return if current_user.try(:admin?)
    redirect_to root_path, :notice => 'You must be an admin to access that page.'
  end
  
end
