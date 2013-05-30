
# Configure Rails Environment
ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../dummy/config/environment", __FILE__)

require 'rspec/rails'
require 'capybara/rspec'

Dir[Refinery.roots(:'refinery/photo_gallery').join("spec/support/**/*.rb")].each {|f| require f }

# Capybara Configuration
Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome, switches: %w[--window-size=1024,768 --ignore-certificate-errors --disable-popup-blocking --disable-translate] )
end

Capybara.javascript_driver = :chrome

RSpec.configure do |config|
  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.include Capybara::DSL, :type => :controller
  config.include ::Devise::TestHelpers, :type => :controller
  # config.extend  ::Refinery::ControllerMacros, :type => :controller
  config.include FactoryGirl::Syntax::Methods

  config.include ActionController::RecordIdentifier
  config.include ActionView::Helpers::TextHelper

  config.mock_with :rspec
  config.use_transactional_fixtures = false
  config.treat_symbols_as_metadata_keys_with_true_values = true

  config.before :each do
    DatabaseCleaner.strategy = (example.metadata[:js] ? :truncation : :transaction)
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end
end


