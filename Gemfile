source 'http://rubygems.org'

gem 'refinerycms-i18n',    '~> 2.0.0'

gemspec

gem 'refinerycms',         '~> 2.0.10'
gem 'refinerycms-testing', '~> 2.0.10'
gem 'acts-as-taggable-on',  '~> 2.3.1'


#loading from gemspec

# -- Cloud storage
# AWS S3 support. Can be disabled if using local file system instead of cloud storage.
#gem 'fog'

# -- Photo resizing
# MiniMagick
#gem "mini_magick"

# RMagick:
#gem "rmagick", :require => 'RMagick'

# FreeImage:
#gem "RubyInline"
#gem "image_science", :git => 'git://github.com/perezd/image_science.git'

# -- EXIF
# Mini exif tool. Can be disabled. Remove exif_read and exif_write filters in photo model
#gem "mini_exiftool"

group :development, :test do
  gem 'debugger',            '~> 1.5.0'
  gem 'rspec-rails',         '~> 2.13.0'
  gem 'sqlite3',             '~> 1.3.7'
  gem 'faker',               '~> 1.1.2'
end

group :test do
  # gem 'capybara',            '~> 2.1.0'
  gem 'chromedriver-helper', '~> 0.0.5'
  gem 'database_cleaner'
  gem 'launchy',             '~> 2.3.0'
  gem 'rspec-instafail',     '~> 0.2.4'
  gem 'selenium-webdriver',  '~> 2.32.1'
  gem 'shoulda-matchers',    '~> 2.1.0'
end