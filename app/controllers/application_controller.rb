class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # authenticate_user! - provided by devise
  
  def authenticate_member!
  end
  
  def authenticate_admin!
  end
  
end
