class FollowersController < ApplicationController
  before_action :check_user_status

  def index
    query(current_user.id)
  end

  def create
    @follower = Follower.new(follower_params)
    parameters = ParameterFollower.new(params[:type_asset], follower_params[:following_user_id], request.referrer, current_user)
    if @follower.save
      if !parameters.type_asset.nil?
        respond_to do |format|
          format.turbo_stream { render turbo_stream: turbo_stream.replace_all(".follow-#{parameters.follower_params}",
            partial: 'shared/button/follow/discover',
            locals:{asset: parameters.asset, followers: parameters.followers, type_asset: parameters.type_asset}) }
        end
      else
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.replace("follow-#{parameters.follower_params}",
                partial: 'shared/button/follow/user',
                locals: { followees: parameters.followers, user_id: parameters.follower_params }),
              turbo_stream.replace("followee_tab",
                partial: "shared/navbar/followee_navbar",
                locals: { followers_count: parameters.followers.count }),
              turbo_stream.replace("follower_tab",
                partial: "shared/navbar/follower_navbar",
                locals: { followees_count: parameters.followees_navbar.count })
            ]
          end
        end
      end
    end
  end

  def discover_follower_index
    query(params["id"])
    render "followers/discover_user_followers/index"
  end

  private
    def follower_params
      params.require(:follower).permit(:follower_id, :following_user_id)
    end

    def query(id)
      @followees = Follower.where(following_user_id: id).includes(:follower).page(params[:page]).per(8)
      @followers = Follower.where(follower_id: current_user.id).page(params[:page]).per(8)
      @user = User.find(id)
      @followees_navbar = Follower.where(following_user_id: id)
      @followers_navbar = Follower.where(follower_id: id)
    end
end
