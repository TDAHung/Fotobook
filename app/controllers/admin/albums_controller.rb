class Admin::AlbumsController < Admin::AuthorizationsController
  def index
    @albums = Album.all.page(params[:page]).per(2)
  end

  def edit
    @album = Album.find_by(id: params["id"])
  end
end
