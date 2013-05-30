FactoryGirl.define do

  factory :album, class: Refinery::PhotoGallery::Album do
    world_trade_center
    title { Faker::Lorem::word }
  end

  factory :photo, class: Refinery::PhotoGallery::Photo do
    sequence(:title){|n| "Photo-#{n}" }
    file { File.open( Refinery.roots(:'refinery/photo_gallery').join('spec/support/default-avatar.png')) }
  end

  factory :album_photo, parent: :photo do
    album
  end
end