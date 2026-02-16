class ApplicationController < ActionController::Base
  before_action :configure_authentication

  helper_method :guest_user

  def guest_user?
    user_signed_in? && current_user.email == "guest@example.com"
  end

  def reject_guest!
    return unless guest_user?
    redirect_to root_path, alert: "ゲストユーザーは閲覧専用です"
  end

  before_action :configure_permitted_parameters,
   if: :devise_controller?
    before_action :configure_authentication
 
  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys:[:name, :bio])

    devise_parameter_sanitizer.permit(:account_update,keys:[:name, :bio])
  end
 
  def configure_authentication
    if admin_controller?
      authenticate_admin!
    else
      authenticate_user! unless action_is_public?
    end
  end
 
  def admin_controller?
    self.class.module_parent_name == 'Admin'
  end
 
  def action_is_public?
    controller_name == 'homes' && action_name == 'top'
  end
end
