class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :move_to_index, except: [:index, :show]
  def index
    @posts = Post.all.order(created_at: "DESC")
    
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    tags = params[:post][:tag_id].split(",")
    if @post.save
      @post.save_tags(tags)
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
    @tags = @post.tags.pluck(:content).join(',')

  end

  def edit
    @post = Post.find(params[:id])
    @tags = @post.tags.pluck(:content).join(',')
    redirect_to root_path unless current_user.id == @post.user_id
  end

  def update
    @post = Post.find(params[:id])
    tags = params[:post][:tag_id].split(",")
    if @post.update(post_params)
      @post.update_tags(tags)
      redirect_to post_path
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to root_path
    end
  end


  private

  def post_params
    params.require(:post).permit(:tweet, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
  
end
