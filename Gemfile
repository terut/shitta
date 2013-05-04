source 'https://rubygems.org'

gem 'rails', '3.2.12'
gem 'mysql2'
gem 'haml'
gem 'turbo-sprockets-rails3'
gem 'redcarpet'
gem 'pygments.rb'

gem 'qiita'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
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
  #gem 'capistrano'
  #gem 'capstrano-ext'
  gem 'guard-rspec'
  gem 'guard-spork'
  if RUBY_PLATFORM =~ /linux/
  gem 'libnotify'
  gem 'rb-inotify', '~> 0.8.8'
  end
  gem 'debugger'
  gem 'pry-rails'
  gem 'pry-debugger'
end
