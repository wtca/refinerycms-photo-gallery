require 'spec_helper'

describe Refinery::PhotoGallery::Album do

    # attr_accessible :title, :description, :address, :note, :tags, :longitude, :latitude
    # acts_as_indexed :fields => [:title, :description]

  it { should have_many(:photos).dependent(:destroy) }

  it { should validate_presence_of(:title) }

  describe '#per_page' do
    it "should set value based on value of albums_per_page config option set during initialization" do
      expect(Refinery::PhotoGallery::Album.per_page).to eq(10)
    end
  end
end