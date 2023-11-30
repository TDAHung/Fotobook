class LikeService
  attr_accessor :likes, :asset, :likeable_id, :type_asset

  def initialize(likeable_id, type_asset)
    @likeable_id = likeable_id
    @type_asset = type_asset
    self.logic
  end

  def logic
    case @type_asset
    when 'Album'
      @likes = Like.where(likeable_type: 'Album')
      @asset = Album.find(@likeable_id)
    when 'Photo'
      @likes = Like.where(likeable_type: 'Photo')
      @asset = Photo.find(@likeable_id)
    end
  end
end
