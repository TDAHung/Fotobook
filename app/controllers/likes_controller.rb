class LikesController < ApplicationController
  before_action :check_user_status

  def create
    @like = Like.new(like_params)
    like_service = LikeService.new(params[:like][:likeable_id], params[:like][:likeable_type])
    if @like.save
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("like-#{like_service.likeable_id}-#{like_service.type_asset}",
          partial: 'shared/button/like',
          locals:{asset: like_service.asset, likes: like_service.likes, type_asset: like_service.type_asset}) }
      end
    end
  end

  def destroy
    like_id = current_user.id
    like_service = LikeService.new(params[:like][:likeable_id], params[:like][:likeable_type])
    like = Like.where(user_id: like_id, likeable_type: like_service.type_asset, likeable_id: like_service.likeable_id).delete_all
    if like
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("like-#{like_service.likeable_id}-#{like_service.type_asset}",
          partial: 'shared/button/like',
          locals:{asset: like_service.asset, likes: like_service.likes, type_asset: like_service.type_asset}) }
      end
    end
  end

  private
  def like_params
    params.require(:like).permit(:user_id, :likeable_type, :likeable_id)
  end
end
