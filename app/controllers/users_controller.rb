class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_user
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  
  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "プロフィールを更新しました"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: "退会しました"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_correct_user
    redirect_to root_path, alert:"権限がありません" unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end

end
