class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_user!
  before_action :reject_guest!, only: [:create, :destroy]

  def create
    user = User.find(params[:followed_id])
  
    unless current_user.following?(user)
      current_user.follow(user)
    end
  
    redirect_back(fallback_location: root_path)
  end
  

  def destroy
    relationship = Relationship.find(params[:id])
  
    return redirect_to request.referer, alert: "権限がありません" unless relationship.follower_id == current_user.id

    current_user.unfollow(relationship.followed)
    redirect_to request.referer
  end
end

