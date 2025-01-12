# frozen_string_literal: false

# some of the comments are in UTF-8
ENV['RAILS_ENV'] = 'test'
require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'
require 'factory_bot_rails'
require 'minitest/unit'
require 'database_cleaner/active_record'

# Configure shoulda-matchers to use Minitest
require 'shoulda/matchers'

DatabaseCleaner.url_allowlist = [
  %r{.*test.*}
]
DatabaseCleaner.strategy = :truncation

include ActionDispatch::TestProcess


class ActiveSupport::TestCase  
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting

  # fixtures :all

  # Add more helper methods to be used by all tests here...
  include FactoryBot::Syntax::Methods
  #include Warden::Test::Helpers
  include ActionMailer::TestHelper
  include ActiveJob::TestHelper

  #Warden.test_mode!

  setup do
    DatabaseCleaner.start
  end

  teardown do
    DatabaseCleaner.clean
  end

end

class ActionController::TestCase

  def log_user_in(user)
    session[:user_id] = user.id
  end

end
