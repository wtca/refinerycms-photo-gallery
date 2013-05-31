require 'spec_helper'

describe Refinery::PhotoGallery::Photo do
  # Associations
  it { should belong_to(:album) }

  # Validations
  it { should validate_presence_of(:title) }

  describe '#set_title' do
    it "should set the title based on the filename if title not given" do
      photo = create(:photo, title: nil)
      expect(photo.title).to eq('Default Avatar')
    end

    it "should use provided title if given" do
      photo = create(:photo, title: 'Special Photo')
      expect(photo.title).to eq('Special Photo')
    end
  end

  # Class Extensions
  describe '#file_accessor :file' do
    it "should allow file attachments" do
      photo = create(:photo)
      expect(photo).to be_persisted
      expect(photo.file).to be_a(Dragonfly::ActiveModelExtensions::Attachment)
    end
  end

  describe 'acts_as_taggable_on :tags' do
    it "should be taggable" do
      photo = create(:photo, :tag_list => "one, two, three")
      expect(photo.tags.size).to be 3
    end
  end

  # Configuration
  describe '#per_page' do
    it "should set value based on value of photos_per_page config option set during initialization" do
      # Refinery::PhotoGallery.photos_per_page
      expect(Refinery::PhotoGallery.photos_per_page).to eq(10)
    end
  end
end

#       acts_as_indexed :fields => [:title, :description]
#       attr_accessible :album_id, :title, :description, :longitude, :latitude, :url, :css_class, :preview_type

#       #TODO validate latitude/longitude - convert from nondecimal to decimal using inspiration from https://github.com/airblade/geo_tools/tree/master/lib/geo_tools
#       include Refinery::PhotoGallery::Validators

#       validates :file, :presence  => true
#       validates_with ImageSizeValidator
#       validates_property :mime_type, :of => :file, :in => ::Refinery::Images.whitelisted_mime_types,
#                          :message => :incorrect_format


#       before_create :exif_read
#       #before_update :exif_write #TODO or use it after update?
#       #TODO delete photo path from db? is it used?

#       def to_param
#         "#{id}-#{title.parameterize}"
#       end

#       def link_url
#         self.url.blank? ? file.single.url : self.url
#       end

#       def preview_link(ext_type = :album)
#         begin
#           type = self.preview_type.blank? ? ext_type : self.preview_type
#           file.url(type)
#         rescue Exception => e
#           file.url(:error_wrong_preview_version)
#         end
#       end

#       private

#       def set_title
#         self.title = self.file.file.basename.titleize unless self.title
#       end

#       def exif_read
#         begin
#           photo = MiniExiftool.new(self.file.file.file, {:numerical=> true})

#           self.title = photo.DocumentName  if !photo.DocumentName.nil?
#           self.longitude = photo.GPSLongitude if self.longitude.nil?
#           self.latitude = photo.GPSLatitude if self.latitude.nil?
#           self.description = photo.ImageDescription if self.description.nil? && photo.ImageDescription != 'Exif_JPEG_PICTURE'
#             # TODO read keywords from exif
#         rescue
#           p "ERROR raised exception during MiniExiftool reading"

#         ensure
#           self.description = "" if self.description.nil?  # Because description is concating in helpers, this can't be null
#         end
#       end


# =begin
#       #TODO add checkbox to check if it should be writed to exif, globally on/off writing
#       def exif_write
#         # should only write if tags are changed as images can be large and thus ExifTool will take a while to write to the file
#         photo = MiniExiftool.new(self.file.file.file)
#         photo.GPSLongitude = self.longitude
#         photo.GPSLatitude = self.latitude
#         photo.DocumentName = self.title
#         photo.ImageDescription = self.description
#         photo.Keywords = self.tags
#         photo.save
#       end
# =end

#     end
#   end
# end

