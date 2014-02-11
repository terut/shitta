source 'https://rubygems.org'

gem 'rails', '4.0.2'
gem 'mysql2'
gem 'haml'
gem 'redcarpet'
gem 'pygments.rb'

gem 'qiita'
gem 'valid_email'

gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'

gem 'jquery-rails'
gem 'bcrypt-ruby'

gem 'dotenv-rails'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

group :production do
  gem 'unicorn'
end

group :development, :test do
  gem 'therubyracer'
  gem 'haml-rails'
  gem 'thin'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
  #gem 'capybara-webkit'
  gem 'poltergeist'
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
