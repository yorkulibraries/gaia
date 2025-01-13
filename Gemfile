source 'http://rubygems.org'

ruby File.read('.ruby-version').strip

## RAILS and server ##
gem 'rails', '~> 7.0.0'

## RAILS related ##
gem 'jbuilder', '~> 2.5'
gem 'bcrypt-ruby', '~> 3.1.2'

gem "therubyracer", platforms: :ruby

## DEPLOYMENT ##
gem 'puma'

## DATABASES ##
gem 'mysql2'

## CSS AND JAVASCRIPT ##
gem 'sass-rails', '5.0.8'
gem "less-rails", "4.0.0"
gem "sprockets-rails"
gem 'importmap-rails'

## BOOTSTRAP && SIMPLE_FORM && FLASH UPLOAD ##
gem 'twitter-bootstrap-rails', "2.2.8" #"3.2.2"
gem "simple_form"

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
  gem 'shoulda'
  gem 'shoulda-matchers'
  gem 'shoulda-context'
  gem 'database_cleaner'
  gem 'rails-controller-testing'

  gem 'sqlite3', '~> 1.4'
end

group :development do
  gem 'web-console'
  gem 'listen'
end
