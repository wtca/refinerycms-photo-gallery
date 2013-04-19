module Refinery
  module PhotoGallery
    module Validators
      class ImageSizeValidator < ActiveModel::Validator

        def validate(record)
          photo = record.file

          if photo.respond_to?(:length) && photo.length > Images.max_image_size
            record.errors[:file] << ::I18n.t('too_big',
                                             :scope => 'activerecord.errors.models.refinery/image',
                                             :size => Images.max_image_size)
          end
        end

      end
    end
  end
end
