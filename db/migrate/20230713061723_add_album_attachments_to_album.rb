class AddAlbumAttachmentsToAlbum < ActiveRecord::Migration[7.0]
  def change
    add_column :albums, :album_attachments, :jsonb
  end
end
