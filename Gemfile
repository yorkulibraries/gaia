source 'http://rubygems.org'

ruby File.read('.ruby-version').strip

## RAILS and related ##
gem 'rails', '~> 5.1.7'
gem 'responders', '~> 2.0'

## RAILS related ##
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
gem 'bcrypt', '~> 3.1.7'

## DEPLOYMENT ##
gem 'puma'

## DATABASES ##
gem 'mysql2', '0.5.3'


## CSS AND JAVASCRIPT ##
gem 'sprockets', '3.7.2' #'2.11.3' # 2.12.0 is broken
gem 'sprockets-rails'
gem 'sass-rails', '< 5.0.8' #5.0.8 onwards for rails 5.2
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2.2'
gem 'jquery-rails'

# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

gem 'jquery-ui-rails', "5.0.5"
gem 'jquery-fileupload-rails'

## BOOTSTRAP && SIMPLE_FORM && FLASH UPLOAD ##
gem 'twitter-bootstrap-rails', "2.2.8" #"3.2.2"
gem "less-rails", "4.0.0"
gem "simple_form", "3.5.1" #"3.4.0" #rails 5.1 => 3.5.1 (< rails 5.2) | 5.1.0 rails 5.2
gem "font-awesome-rails", '~> 4.7.0'
gem 'chosen-rails', "0.9.11.2"

## TOOLS AND UTILITIES ##
gem 'kaminari', "0.17.0" #"0.15.1"
gem "cancancan", "1.15.0"
gem "rubyzip", "2.3.2"

## UPLOADING AND MANIPULATING FILES ##
gem "carrierwave", "0.10.0" #https://rubygems.org/gems/carrierwave/versions/1.0.0
gem "mini_magick", "3.7.0"

# NOTIFICATIONS
gem 'exception_notification', "4.4.3" #RAILS 5.2 make it 4.5.0

## TESTING && DEVELOPMENT ##
gem 'guard-livereload', require: false
gem "rack-livereload"

group :test do

  gem "minitest", "5.15.0" #, "5.6.1"
  gem 'webrat', "0.7.3"
  gem 'factory_girl_rails', "4.5.0"
  gem 'shoulda', "3.6"
  gem 'shoulda-matchers'
  gem 'shoulda-context'
  gem "mocha", "0.14", require: false
  gem "capybara", "2.1.0"
  gem 'database_cleaner', "1.2.0"
  gem "guard-minitest", "2.4.6"
  gem "ruby-prof"
  gem 'rails-controller-testing'

  gem 'sqlite3', '~> 1.3.0'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen' #, '~> 3.0.5'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'nifty-generators', "0.4.6"
  gem "populator", git: "https://github.com/ryanb/populator.git"
  gem "faker"
  gem "bullet" # Testing SQL queries
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end


