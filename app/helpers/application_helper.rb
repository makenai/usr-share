module ApplicationHelper
  
  def admin_content
    concat content_tag( 'span', :class => 'admin' ) { yield } if current_user.try(:admin?)
  end
  
  def nonadmin_content
    yield unless current_user.try(:admin?)
  end
  
  def member_content
    yield if current_user.try(:member?)    
  end
  
  def nonmember_content
    yield unless current_user.try(:member?)
  end
  
  def user_content
    yield if current_user
  end
  
  def category_label( category )
    shape = Category::SHAPE_SYMBOLS[ category.shape ]
    content_tag( :span, raw("#{shape} #{category.code} #{shape}"), :style => "color: ##{category.color};", :class => 'label' )
  end
  
  def media_label( media )
    category = media.subcategory.category
    shape = Category::SHAPE_SYMBOLS[ category.shape ]
    content_tag( :span, raw("#{shape} #{media.label.join(' ')} #{shape}"), :style => "color: ##{category.color};", :class => 'medialabel' )    
  rescue
    ''
  end

  def link_to_active_if( condition, link_title, link_path = {}, opts = {} )
    if condition
      classes = opts.delete(:class) || ""
      classes.rstrip!
      # checking to see if "active" is already one of the classes assigned, and if NOT, append it to the classes string
      unless classes =~ /^(\w*\s+)*active(?!\w)/ 
        if classes.blank? 
          classes = 'active'
        else
          classes << " active"
        end         
      end    
    end
    old_opts = opts.dup
    link_to_if( condition, link_title, link_path, opts.merge( {:class => classes} ) ) {
      link_to( link_title, link_path, old_opts )
    }
  end
  
  def link_to_active_if_current( link_title, link_path = {}, opts = {} )  	  
   	  link_to_active_if current_page?(link_path), link_title, link_path, opts
  end
    
end
