class Public::UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_user
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :ensure_guest_user, only: [:edit]
  
  def show
    @user = User.find(params[:id])
  
    if user_signed_in? && @user == current_user
      
      @posts = @user.posts.order(created_at: :desc)
    else
      
      @posts = @user.posts.where(is_public: true).order(created_at: :desc)
    end
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

  def following
    @user = User.find(params[:id])
    @users = @user.following
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end
  

  private

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end  

  def user_params
    params.require(:user).permit(:name, :email)
  end

end
