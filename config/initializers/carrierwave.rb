require 'carrierwave/orm/activerecord'
CarrierWave.configure do |config|
  config.storage = :file
end
