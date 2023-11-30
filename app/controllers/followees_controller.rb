class FolloweesController < ApplicationController
  before_action :check_user_status

  def index
    query(current_user.id)
  end

  def destroy
    parameter = ParameterFollowee.new(params[:type_asset], params[:id], request.referrer, current_user)
    query = Follower.where(follower_id: parameter.follower_id,following_user_id: parameter.followee_params_id).delete_all
    if query
        if parameter.type_asset
          respond_to do |format|
            format.turbo_stream { render turbo_stream: turbo_stream.replace_all(".follow-#{parameter.followee_params_id}", partial: 'shared/button/follow/discover',
              locals:{asset: parameter.asset, followers: parameter.followers, type_asset: parameter.type_asset}) }
          end
        else
          respond_to do |format|
            format.turbo_stream do
              render turbo_stream: [
                turbo_stream.replace("follow-#{parameter.followee_params_id}",
                  partial: 'shared/button/follow/user',
                  locals: { followees: parameter.followers, user_id: parameter.followee_params_id}),
                turbo_stream.replace("follower_tab",
                  partial: "shared/navbar/follower_navbar",
                  locals: { followees_count: parameter.followees_navbar.count }),
                turbo_stream.replace("followee_tab",
                  partial: "shared/navbar/followee_navbar",
                  locals: { followers_count: parameter.followees_navbar.count })
              ]
              end
          end
        end
    end
  end

  def discover_followee_index
    query(params["id"])
    render "followees/discover_user_followees/index"
  end

  private
    def query(id)
      @followers = Follower.where(follower_id: id).includes(:following_user).page(params[:page]).per(8)
      @followees = Follower.where(following_user_id: current_user.id).page(params[:page]).per(8)
      @user = User.find(id)
      @followees_navbar = Follower.where(following_user_id: id)
      @followers_navbar = Follower.where(follower_id: id)
    end
end
