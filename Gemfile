source 'http://rubygems.org'

ruby File.read('.ruby-version').strip

## RAILS and related ##
gem 'rails', '~> 5.2.0'

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
gem "simple_form"
gem "font-awesome-rails", '~> 4.7.0'
gem 'chosen-rails'

## TOOLS AND UTILITIES ##
gem 'kaminari'
gem "cancancan"
gem "rubyzip"

## UPLOADING AND MANIPULATING FILES ##
gem "carrierwave"
gem "mini_magick"

group :test do

  gem "minitest"
  gem "factory_bot_rails"
  gem 'shoulda', "3.6"
  gem 'shoulda-matchers'
  gem 'shoulda-context'
  gem 'database_cleaner'
  gem 'rails-controller-testing'

  gem 'sqlite3', '~> 1.3.0'
end

group :development do
  gem 'web-console'
end

