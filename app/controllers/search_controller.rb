class SearchController < ApplicationController
  def index
    @followers = Follower.where(follower_id: current_user.id)
    album_query = Album.order(updated_at: :desc).where(is_public: true).includes(:user).ransack(params[:q])
    @likes_album = Like.where(likeable_type: 'Album')

    photo_query = Photo.order(updated_at: :desc).where(is_public: true).includes(:user).ransack(params[:q])
    @likes_photo = Like.where(likeable_type: 'Photo')
    @albums = album_query.result(distinct: true)
    @photos = photo_query.result(distinct: true)
    @result = @albums + @photos
    @result = @result.sort_by { |record| record.updated_at }.reverse
    @result = Kaminari.paginate_array(@result).page(params[:page]).per(4)
  end
end
