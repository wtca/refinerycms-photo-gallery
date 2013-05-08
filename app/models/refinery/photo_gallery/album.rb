module Refinery
  module PhotoGallery
    class Album < ActiveRecord::Base
      has_many :photos, :dependent => :destroy
      has_many :collection_albums , :dependent => :destroy
      has_many :collections, :through => :collection_albums


      validates :title, :presence => true

      attr_accessible :title, :description, :address, :note, :tags, :longitude, :latitude, :collection_ids
      acts_as_indexed :fields => [:title, :description]

      self.per_page = Refinery::PhotoGallery.albums_per_page


      def self.with_collection_id
        select("refinery_photo_gallery_albums.*, refinery_photo_gallery_collection_albums.collection_id ").joins(:collection_albums)
      end

      if ActiveRecord::Base.connection.table_exists? self.table_name
        scope :find_by_collection_id, lambda {|collection_id|
          select("refinery_photo_gallery_albums.*").
              joins(:collection_albums).
              where("refinery_photo_gallery_collection_albums.collection_id = ?
                      ", collection_id).
              order('created_at DESC, title ASC')
        }
      end

      def collection_ids
        Refinery::PhotoGallery::CollectionAlbum.select('collection_id').where("album_id = ?", self.id ).map{|ca| ca.collection_id }
      end

    end
  end
end
