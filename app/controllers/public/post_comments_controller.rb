class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_post
  before_action :set_post_comment, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :reject_guest!, only: [:create, :destroy]

  def create
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.post = @post
  
    if @post_comment.save
      redirect_to post_path(@post), notice: "コメントしました"
    else
      @post_comments = @post.post_comments.includes(:user).order(created_at: :desc)
      flash.now[:alert] = "コメントを入力してください"
      render "public/posts/show", status: :unprocessable_entity
    end
  end
  

  def edit
  end

  def update
    return redirect_to @post, alert: "編集権限がありません" unless @post_comment.user_id == current_user.id
  
    if @post_comment.update(post_comment_params)
      redirect_to @post, notice: "コメントを更新しました"
    else
      flash.now[:alert] = "コメントを入力してください"
      render :edit, status: :unprocessable_entity
    end
  end
  

  def destroy
    unless @post_comment.user_id == current_user.id || @post.user_id == current_user.id
      return redirect_to request.referer, alert: "削除権限がありません"
    end

    @post_comment.destroy
    redirect_to request.referer, notice: "コメントを削除しました"
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_post_comment
    @post_comment = @post.post_comments.find(params[:id])
  end

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
