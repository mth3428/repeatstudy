class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :move_to_index, except: [:index, :show]
  def index
    @posts = Post.all.order(created_at: "DESC")
    @tags=Tag.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id=current_user.id
    tags = params[:post][:content].split(',')
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
    tags = params[:post][:content].split(',')
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
    params.require(:post).permit(:tweet, :image, :tag_id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
  
end
