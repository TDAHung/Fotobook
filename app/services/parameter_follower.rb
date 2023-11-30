class ParameterFollower
  attr_accessor :type_asset, :follower_params, :asset, :followers, :followees_navbar, :current_user

  def initialize(type_asset, follower_params, referrer_url, current_user)
    @type_asset = type_asset
    @follower_params = follower_params
    @referrer_url = referrer_url
    @current_user = current_user
    self.logic
  end

  def logic
    url = URI.parse(@referrer_url).path
    desired_portion = url.split('/')[1]
    discover_id = url.split('/')[3]
    if desired_portion != "discovers"
      @followees_navbar = Follower.where(follower_id: @current_user.id)
    else
      @followees_navbar = Follower.where(following_user_id: discover_id)
    end
    case @type_asset
    when 'Album'
      @asset = Album.where(user_id: @follower_params).first
    when 'Photo'
      @asset = Photo.where(user_id: @follower_params).first
    end
    @followers = Follower.where(follower_id: @current_user.id)
  end
end

