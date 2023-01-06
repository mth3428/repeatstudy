class RelationshipsController < ApplicationController

  before_action :authenticate_user!
  
  def create
    following = current_user.relationships.build(follower_id: params[:user_id])
    following.save
    redirect_to request.referrer || root_path
          # request.referrerは以前のパスに戻る  || root_pathは、もしそのパスが見当たらなければroot_pathに戻る
  end

  def destroy
    following = current_user.relationships.find_by(follower_id: params[:user_id])
    following.destroy
    redirect_to request.referrer || root_path
  end

  

end
