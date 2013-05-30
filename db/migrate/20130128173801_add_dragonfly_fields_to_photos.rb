class AddDragonflyFieldsToPhotos < ActiveRecord::Migration
  def change
    add_column :refinery_photo_gallery_photos, :file_uid, :string
    add_column :refinery_photo_gallery_photos, :file_name, :string
  end
end
