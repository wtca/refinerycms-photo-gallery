require 'dragonfly'

module Refinery
  module PhotoGallery
    class Photo < ActiveRecord::Base
      ::Refinery::PhotoGallery::Dragonfly.setup!

      belongs_to :album

      file_accessor :file

      acts_as_taggable_on(:tags)
      acts_as_indexed :fields => [:title, :description]

      attr_accessible :tag_list
      attr_accessible :album_id, :title, :description, :longitude, :latitude, :url, :css_class, :preview_type
      validates :title, :presence => true
      #TODO validate latitude/longitude - convert from nondecimal to decimal using inspiration from https://github.com/airblade/geo_tools/tree/master/lib/geo_tools
      include Refinery::PhotoGallery::Validators

      validates :file, :presence  => true
      validates_with ImageSizeValidator
      validates_property :mime_type, :of => :file, :in => ::Refinery::Images.whitelisted_mime_types,
                         :message => :incorrect_format

      before_validation :set_title
      # after_validation :geocode
      before_create :exif_read
      #before_update :exif_write #TODO or use it after update?
      #TODO delete photo path from db? is it used?

      self.per_page = Refinery::PhotoGallery.photos_per_page

      def to_param
        "#{id}-#{title.parameterize}"
      end

      def link_url
        self.url.blank? ? file.single.url : self.url
      end

      def preview_link(ext_type = :album)
        begin
          type = self.preview_type.blank? ? ext_type : self.preview_type
          file.url(type)
        rescue Exception => e
          file.url(:error_wrong_preview_version)
        end
      end

      private

      def set_title
        return if title || self.file.nil?
        self.title = self.file.basename.titleize
      end

      def exif_read
        begin
          photo = MiniExiftool.new(self.file.file.file, {:numerical=> true})

          self.title = photo.DocumentName  if !photo.DocumentName.nil?
          self.longitude = photo.GPSLongitude if self.longitude.nil?
          self.latitude = photo.GPSLatitude if self.latitude.nil?
          self.description = photo.ImageDescription if self.description.nil? && photo.ImageDescription != 'Exif_JPEG_PICTURE'
            # TODO read keywords from exif
        rescue
          p "ERROR raised exception during MiniExiftool reading"

        ensure
          self.description = "" if self.description.nil?  # Because description is concating in helpers, this can't be null
        end
      end


=begin
      #TODO add checkbox to check if it should be writed to exif, globally on/off writing
      def exif_write
        # should only write if tags are changed as images can be large and thus ExifTool will take a while to write to the file
        photo = MiniExiftool.new(self.file.file.file)
        photo.GPSLongitude = self.longitude
        photo.GPSLatitude = self.latitude
        photo.DocumentName = self.title
        photo.ImageDescription = self.description
        photo.Keywords = self.tags
        photo.save
      end
=end

    end
  end
end

