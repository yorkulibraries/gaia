source 'http://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

#ruby "2.4.10"
# ruby "2.7.0"
ruby "2.6.9"

gem 'bundler', '1.17.3'

## RAILS and related ##
# gem "rails", "4.2.6"
# gem "rails", "4.2.11.3"
# gem "rails", "5.0.7.2"
# gem 'rails', '~> 5.0.7', '>= 5.0.7.2'
gem 'rails', '~> 5.1.7'
gem 'responders', '~> 2.0'

## RAILS related ##
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# gem 'jbuilder', '~> 1.2'
# gem 'bcrypt-ruby', '~> 3.1.2'
gem 'bcrypt', '~> 3.1.7'

## DEPLOYMENT ##
# gem 'capistrano', '~> 3.4.0'
# gem 'capistrano-rails', '~> 1.1.0'
# gem 'capistrano-bundler'
# gem 'capistrano-rbenv', "~> 2.0"
# gem 'puma', '~> 3.0'
gem 'puma', '~> 3.7'

## DATABASES ##
gem 'sqlite3', '~> 1.3.0'
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
# gem 'bookable', '~> 0.0.52'
gem 'kaminari', "0.17.0" #"0.15.1"
# gem "cancan", "1.6.9"
gem "cancancan", "1.15.0"
gem "rubyzip", "2.3.2"
# gem "rubyzip", "0.9.9"

## SQUEEL NO LONGER SUPPORTED higher than 4.
# If must have, explore https://github.com/rzane/baby_squeel/issues/20
# gem "squeel", "1.2.3"

# gem "audited-activerecord", "4.2.2" is replaced by
# gem "audited", "~> 5.0" # Maybe have to run: rails generate audited:upgrade

## UPLOADING AND MANIPULATING FILES ##
gem "carrierwave", "0.10.0" #https://rubygems.org/gems/carrierwave/versions/1.0.0
gem "mini_magick", "3.7.0"
# gem "mime-types", "1.25.1"

# NOTIFICATIONS
# gem 'exception_notification', "4.1.4"
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
  # gem 'capybara', '>= 2.15'
  gem 'database_cleaner', "1.2.0"
  # # gem "guard-minitest", "2.4.4"
  gem "guard-minitest", "2.4.6"
  #
  # gem 'spring', "1.3.6"
  gem "ruby-prof"
  gem 'rails-controller-testing'

end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen' #, '~> 3.0.5'
  # gem 'listen', '>= 3.0.5', '< 3.2'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'nifty-generators', "0.4.6"
	gem "populator", git: "https://github.com/ryanb/populator.git"
	gem "faker"
  gem "bullet" # Testing SQL queries
	gem "mailcatcher" # FOR TESTING MAIL. Run mailcatcher, then go to localhost:1080
  # gem 'web-console', '~> 2.0'
end

group :development, :test do
  # gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # gem 'byebug', platform: :mri
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
