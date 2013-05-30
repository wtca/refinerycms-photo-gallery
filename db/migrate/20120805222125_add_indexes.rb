class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index Refinery::PhotoGallery::Album.table_name, :id, :unique => true
    add_index Refinery::PhotoGallery::Photo.table_name, :id, :unique => true
    add_index Refinery::PhotoGallery::Photo.table_name, :album_id
  end

  def self.down
    remove_index Refinery::PhotoGallery::Album.table_name, :id
    remove_index Refinery::PhotoGallery::Photo.table_name, :id
    remove_index Refinery::PhotoGallery::Photo.table_name, :album_id

  end
end
