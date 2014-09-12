ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  #config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.before(:all) do
    FactoryGirl.reload # これがないとfactoryの変更が反映されません
  end

  #pid = 0
  config.before(:suite) do
    #cmd = "afplay ~/Music/ff5_2_03_bigbridge.mp3"
    #pid = Process.spawn(cmd, err: '/dev/null')
  end

  config.after(:suite) do
    unless config.reporter.failed_examples.count > 0
      case RUBY_PLATFORM
      when /darwin/
        `qlmanage -p #{Rails.root}/spec/support/images/rg0wNNb.gif >& /dev/null &`
      else /win32/
      end
    end
    #Process.kill("QUIT", pid)
    #cmd = "afplay ~/Music/ff6_1_06_fanfare.mp3"
    #pid = Process.spawn(cmd, err: '/dev/null')
    #sleep 5
    #Process.kill("HUP", pid)
  end

  class ActiveRecord::Base
    mattr_accessor :shared_connection
    @@shared_connection = nil

    def self.connection
      @@shared_connection || retrieve_connection
    end
  end
end
