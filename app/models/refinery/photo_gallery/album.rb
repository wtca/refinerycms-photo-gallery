module Refinery
  module PhotoGallery
    class Album < ActiveRecord::Base
      has_many :photos, :dependent => :destroy

      validates :title, :presence => true

      attr_accessible :title, :description, :address, :note, :tags, :longitude, :latitude
      acts_as_indexed :fields => [:title, :description]

      self.per_page = Refinery::PhotoGallery.albums_per_page

    end
  end
end
