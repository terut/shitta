# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file
  process resize_to_fill: [200, 200]

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    '/images/user_default.jpg'
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    return unless original_filename

    "#{Digest::MD5.hexdigest(original_filename)}#{File.extname(super)}"
  end
end
