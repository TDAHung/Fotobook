class AlbumsController < ApplicationController
  before_action :check_user_status
  before_action :check_user

  def index
    @albums = Album.where(user_id: current_user.id).order(updated_at: :desc).page(params[:page]).per(8)
    query_navbar(current_user.id)
    @photos = Photo.where(user_id: current_user.id)
  end

  def new
    @album = Album.new
  end

  def create
    @album = current_user.albums.build(album_params)
    if @album.save
      redirect_to discover_album_path(@album.user_id)
    else
      render 'new'
    end
  end

  def edit
    @album = Album.find(params["id"])
  end

  def update
    @album = Album.find(params["id"])
    if @album.update(album_params)
      redirect_to discover_album_path(@album.user_id)
    else
      render 'edit'
    end
  end

  def destroy
    @album = Album.find(params["id"])
    @album.destroy
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  def discover_user_index
    @albums = Album.where(user_id: params["id"]).where(is_public: true).includes(:user)
    .order(updated_at: :desc).page(params[:page]).per(8)
    query_navbar(params[:id])
    @photos = Photo.where(user_id: params["id"]).where(is_public: true)
    render "albums/discover_user_albums/index"
  end

  def index_feed
    followees_ids = Follower.where(follower_id: current_user.id).pluck(:following_user_id)
    @albums = Album.includes(:user).order(updated_at: :desc).where(is_public: true)
    .where(user_id: followees_ids).page(params[:page]).per(4)
    @likes = Like.where(likeable_type: 'Album')
    render "public/feeds/index"
  end

  def index_discover
    @albums = Album.order(updated_at: :desc).where(is_public: true).includes(:user).page(params[:page]).per(4)
    @followers = Follower.where(follower_id: current_user.id)
    @likes = Like.where(likeable_type: 'Album')
    render "public/discovers/index"
  end

  private
    def album_params
      params.require(:album).permit(:title, :description, :is_public, {album_attachments: []})
    end

    def check_user
      if params["id"] === current_user.id.to_s && action_name != 'edit'
        redirect_to albums_path
      end
    end

    def query_navbar(id)
      @user = User.includes(:albums).includes(:photos).find(id)
      @followees_navbar = Follower.where(following_user_id: id)
      @followers_navbar = Follower.where(follower_id: id)
    end
end
