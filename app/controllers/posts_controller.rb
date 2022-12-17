class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  
  def index
    @posts = Post.all.order(created_at: "DESC")
    
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show

  end

  private

  def post_params
    params.require(:post).permit(:tweet, :image).merge(user_id: current_user.id)
  end

end
