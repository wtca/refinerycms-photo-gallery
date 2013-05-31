require 'spec_helper'

describe Refinery::PhotoGallery::Album do
  # attr_accessible :title, :description, :address, :note, :tags, :longitude, :latitude
  # acts_as_indexed :fields => [:title, :description]

  # Associations
  it { should have_many(:photos).dependent(:destroy) }

  # Validatioins
  it { should validate_presence_of(:title) }

  # Configuration
  describe '#per_page' do
    it "should set value based on value of albums_per_page config option set during initialization" do
      # Refinery::PhotoGallery.albums_per_page
      expect(Refinery::PhotoGallery::Album.per_page).to eq(10)
    end
  end
end