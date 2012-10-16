module Admin::UsersHelper
  
  def is_admin_image(is_admin)
    is_admin ? '/assets/admin/true.png' : '/assets/admin/false.png'
  end
end
