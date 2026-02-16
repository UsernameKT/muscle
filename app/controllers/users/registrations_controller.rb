class Users::RegistrationsController < Devise::RegistrationsController

  before_action :check_guest, only: [:edit, :update, :destroy]

  private

  def check_guest
    if current_user.guest_user?
      redirect_to root_path,alert: "ゲストユーザーは編集・削除できません"
    end
  end

  def update_resource(resource, params)
    params.delete(:current_password)
    resource.update_without_password(params)
  end
  
end
