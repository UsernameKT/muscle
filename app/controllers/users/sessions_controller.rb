class Users::SessionsController < Devise::SessionsController

  def guest_sign_in
    user = User.find_or_create_by!(email:'guest@example.com') do |u|
      u.password = SecureRandom.urlsafe_base64
      u.name = "ゲストユーザー"
    end

    sign_in user
    redirect_to user_path(user), notice: "ゲストユーザーでログインしました。"
  end
  
end


