source 'http://rubygems.org'

gem 'rails', '3.1.0'
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end
gem 'jquery-rails'

gem 'amazon-ecs'
gem 'rghost'
gem 'rghost_barcode'
gem 'omniauth'
gem 'devise'
gem 'table_builder', :git => 'git://github.com/sashaparfenov/table_builder.git'
gem 'kaminari'
gem 'ri_cal'
gem "prawn-labels", :git => 'git://github.com/makenai/prawn-labels.git'
# gem "prawn-labels", :path => '~/Projects/prawn-labels'

group :development do
  gem "nifty-generators"
  gem 'sqlite3'
  gem 'heroku'
  gem 'guard-rspec'
  gem 'growl_notify'
end

group :test do
  gem 'turn', :require => false
  gem "mocha"
end

group :test, :development do
  gem "rspec-rails", "~> 2.6"
end

group :production do
  gem 'therubyracer-heroku'
  gem 'pg'
end