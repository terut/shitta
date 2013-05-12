require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'capybara/rails'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.include FactoryGirl::Syntax::Methods

    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    config.use_transactional_fixtures = true

    config.infer_base_class_for_anonymous_controllers = true

    config.order = "random"

    #pid = 0
    config.before(:suite) do
      #cmd = "afplay ~/Music/ff5_2_03_bigbridge.mp3"
      #pid = Process.spawn(cmd, err: '/dev/null')
    end

    config.after(:suite) do
      #Process.kill("QUIT", pid)
      #cmd = "afplay ~/Music/ff6_1_06_fanfare.mp3"
      #pid = Process.spawn(cmd, err: '/dev/null')
      #sleep 5
      #Process.kill("HUP", pid)
    end
  end

  class ActiveRecord::Base
    mattr_accessor :shared_connection
    @@shared_connection = nil

    def self.connection
      @@shared_connection || retrieve_connection
    end
  end
end

Spork.each_run do
  FactoryGirl.reload
  ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
end
