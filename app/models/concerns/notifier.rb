# TODO Test
module Notifier
  include Rails.application.routes.url_helpers

  HIPCHAT_API_TOKEN = ENV['SHITTA_HIPCHAT_API_TOKEN']
  HIPCHAT_ROOM = ENV['SHITTA_HIPCHAT_ROOM']

  def client
    @client ||= HipChat::Client.new(HIPCHAT_API_TOKEN)
  end

  def room
    HIPCHAT_ROOM
  end

  def post_notify(model)
    message = "Oh,cool. New post arrived: #{model.title} #{note_url(model)}"
    notify(message)
  end

  private
  def notify(message)
    client[room].send('shitta', message, color: 'green', notify: true, message_format: 'text')
  end

  def default_url_options
    # TODO Refactoring
    ActionMailer::Base.default_url_options
  end
end
