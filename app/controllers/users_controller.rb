class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: "DESC")
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def index
    @users = User.where.not(id: current_user.id)
    # current_userのid以外のuserの全てのidを取ってくる
  end

  # あるuserがフォローしている人全員を取得するアクションを定義
  def followings
    user = User.find(params[:id])
    @users = user.followings
        # このuserがフォローしている人全員を取ってくる
  end

  # あるuserをフォローしている人全員を取得するアクションを定義
  def followers
    user = User.find(params[:id])
    @users = user.followers
        # このuserをフォローしている人全員を取ってくる
  end

  

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :introduction, :image).merge(post_id: params[:post_id])
  end

end
