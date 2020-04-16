class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_action, only:[:show, :destroy]
  def new
    @post = Post.new
    @post.photos.build
  end

  def create
    @post = Post.new(post_params)
    if @post.photos.present?
      @post.save
      redirect_to root_path
      flash[:notice] = "投稿が保存されました"
    else
      redirect_to new_post_path
      flash[:alert] = "投稿に失敗しました"
    end
  end

  def index
    @posts = Post.limit(10).includes(:photos, :user).order('created_at DESC')
  end


  def show
  end

  def destroy
    if @post.user == current_user
      if @post.destroy
      redirect_to root_path
      flash[:notice] ="削除しました"
      else
      redirect_to root_path
      flash[:alert] ="削除に失敗しました"
      end
    end
  end

  private
    def post_params
      params.require(:post).permit(:caption, photos_attributes: [:image]).merge(user_id: current_user.id)
    end
  
    def set_action
      @post = Post.find(params[:id])
    end
end
