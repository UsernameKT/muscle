class Public::FavoritesController < ApplicationController

  before_action :authenticate_user!
  before_action :reject_guest!, only: [:create, :destroy]

  def create
    @post = Post.find(params[:post_id])
    current_user.favorites.create(post_id: @post.id)
    redirect_to post_path(@post), notice: "いいねしました"
  end
  

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite&.destroy
    redirect_to post_path(@post), notice: "いいねを解除しました"
  end
  
end
