class RemoveAlbumIdFromPhotos < ActiveRecord::Migration[7.0]
  def up
    remove_reference :photos, :album, foreign_key: true
  end

  def down
    add_reference :photos, :album, foreign_key: true
  end
end
