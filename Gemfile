source 'https://rubygems.org'
source 'https://rails-assets.org'

ruby '2.2.0'

gem 'rails', '4.2.0'

gem 'awesome_print'
gem 'bootstrap_form', '2.2.0' # Form helpers for Bootstrap
gem 'devise', '3.4.1'
gem 'elasticsearch-model', '0.1.6' # ActiveModel/Record integrations for ElasticSearch
gem 'elasticsearch-rails', '0.1.6' # Use ElasticSearch for search backend
gem 'faker', '1.4.3' # Generate fake names, addresses, etc.
gem 'jbuilder', '~> 2.0' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'lograge' # Cleaner logging (in key=value format ala Heroku)
gem 'pg', '0.17.1' # Postgresql database
gem 'progress_bar' # Pretty progress bars on the command line
gem 'sdoc', '~> 0.4.0', group: :doc # bundle exec rake doc:rails generates the API
gem 'unicorn' # Webserver

# Assets
gem 'coffee-rails', '~> 4.1.0' # CoffeeScript for .coffee assets and views
gem 'jquery-rails' # JavaScript library
gem 'neat', '1.7.0' # Lightweight semantic grid framework for Sass and Bourbon
gem 'sass-rails', '~> 5.0' # Sass/Scss for stylesheets
gem 'uglifier', '>= 1.3.0' # Compressor for JavaScript assets
gem 'bootstrap-sass', '~> 3.3.1'

group :development, :test do
  gem 'bullet' # Detect expensive N+1 queries
  gem 'guard'
  gem 'guard-rspec'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'byebug' # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'spring' # Speeds up development by keeping application running in the background
  gem 'web-console', '~> 2.0' # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'quiet_assets', '1.1.0' # Remove noisy asset requests from log
end

group :production do
  gem 'rails_12factor'
end
