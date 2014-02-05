source 'https://rubygems.org'

gem 'rails', '4.0.2'
gem 'mysql2'
gem 'haml'
gem 'turbo-sprockets-rails3'
gem 'redcarpet'
gem 'pygments.rb'

gem 'qiita'
gem 'valid_email'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'therubyracer'
end

gem 'jquery-rails'
gem 'bcrypt-ruby'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

group :production do
  gem 'unicorn'
end

group :development, :test do
  gem 'haml-rails'
  gem 'thin'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
  #gem 'capybara-webkit'
  gem 'poltergeist'
  #gem 'capistrano'
  #gem 'capstrano-ext'
  gem 'guard-rspec'
  gem 'guard-spork'
  if RUBY_PLATFORM =~ /linux/
    gem 'libnotify'
    gem 'rb-inotify'
  end
  gem 'byebug'
  gem 'pry-rails'
  gem 'pry-byebug'
end
