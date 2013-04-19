require 'dragonfly'

module Refinery
  module PhotoGallery
    module Dragonfly

      class << self
        def setup!
          app_images = ::Dragonfly[:refinery_images]

          app_images.define_macro(::Refinery::PhotoGallery::Photo, :file_accessor)
          app_images.job :album do
            process(:resize_and_crop, "#{Refinery::PhotoGallery.album_dimensions[0]}x#{Refinery::PhotoGallery.album_dimensions[1]}#n")
            process(:auto_orient)
          end

          app_images.job :preview do
            process(:resize, Refinery::PhotoGallery.preview_dimensions.join('x') )
            process(:auto_orient)
          end

          app_images.job :single do
            process(:resize, "#{ Refinery::PhotoGallery.single_dimensions.join('x') }>")
            process(:auto_orient)
          end
        end

        def configure!
          app_images = ::Dragonfly[:refinery_images]


        end

        def attach!(app)
          ### Extend active record ###
          # app.config.middleware.insert_before Refinery::Images.dragonfly_insert_before,
          #                                     'Dragonfly::Middleware', :refinery_images

          # app.config.middleware.insert_before 'Dragonfly::Middleware', 'Rack::Cache', {
          #   :verbose     => Rails.env.development?,
          #   :metastore   => "file:#{Rails.root.join('tmp', 'dragonfly', 'cache', 'meta')}",
          #   :entitystore => "file:#{Rails.root.join('tmp', 'dragonfly', 'cache', 'body')}"
          # }
        end
      end

    end
  end
end
