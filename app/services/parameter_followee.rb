class ParameterFollowee
  attr_accessor :type_asset, :followee_params_id, :asset, :followers, :followees_navbar, :follower_id

  def initialize(type_asset, followee_params_id, referrer_url, current_user)
    @type_asset = type_asset
    @followee_params_id = followee_params_id
    @referrer_url = referrer_url
    @current_user = current_user
    self.logic
  end

  def logic
    @follower_id = @current_user.id
    url = URI.parse(@referrer_url).path
    desired_portion = url.split('/')[1]
    discover_id = url.split('/')[3]
    if desired_portion == "discovers"
      @followees_navbar = Follower.where(following_user_id: discover_id)
    else
      @followees_navbar = Follower.where(follower_id: @follower_id)
    end
    case @type_asset
    when 'Album'
      @asset = Album.where(user_id: @followee_params_id).first
    when 'Photo'
      @asset = Photo.where(user_id: @followee_params_id).first
    end
    @followers = Follower.where(follower_id: @follower_id)
  end
end

#following_user_id | @followee_params_id = params[:id]
