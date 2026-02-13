class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_to request.referer
  end

  def destroy
    relationship = Relationship.find(params[:id])
  
    return redirect_to request.referer, alert: "権限がありません" unless relationship.follower_id == current_user.id

    current_user.unfollow(relationship.followed)
    redirect_to request.referer
  end
end

