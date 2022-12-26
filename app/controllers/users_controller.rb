class UsersController < ApplicationController

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

  

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :introduction, :image).merge(post_id: params[:post_id])
  end

end
