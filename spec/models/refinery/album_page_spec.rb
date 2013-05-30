require 'spec_helper'

describe Refinery::AlbumPage do
  it { should belong_to(:album).class_name('Refinery::PhotoGallery::Album') }
  it { should belong_to(:page) }

end
