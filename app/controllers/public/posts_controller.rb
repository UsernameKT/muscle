class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]


  def index
    if user_signed_in?
      @posts = Post.where(is_public: true)
                   .or(Post.where(user_id: current_user.id))
                   .order(created_at: :desc)
    else
      @posts = Post.where(is_public: true).order(created_at: :desc)
    end
  end
  
  

  def show
    @post = Post.find(params[:id])
  
    if !@post.is_public && @post.user != current_user
      redirect_to posts_path, alert: "この投稿は非公開です"
      return
    end

    @post_comment = PostComment.new
  end
  
  

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "投稿に成功しました。"
      redirect_to @post
    else
      flash[:notice] = "投稿に失敗しました。"
      render :new
    end
  
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post =current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to @post,notice: "更新しました"
    else
      render :edit
    end
  end
  
  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to posts_path,notice: "削除しました"
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :is_public)
  end

  def postcomment_params
    params.require(:post_comment).permit(:comment)
  end
  
end
