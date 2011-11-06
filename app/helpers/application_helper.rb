module ApplicationHelper
  
  def admin_content
    yield if current_user.try(:admin?)
  end
  
  def member_content
    yield if current_user.try(:member?)    
  end
  
  def nonmember_content
    yield unless current_user.try(:member?)
  end
  
end
