# TODO Test and refactoring
module Notifier
  include Rails.application.routes.url_helpers

  HIPCHAT_API_TOKEN = ENV['SHITTA_HIPCHAT_API_TOKEN']
  HIPCHAT_ROOM = ENV['SHITTA_HIPCHAT_ROOM']

  def client
    @client ||= HipChat::Client.new(HIPCHAT_API_TOKEN, api_version: 'v2')
  end

  def room
    HIPCHAT_ROOM
  end

  def post_notify
    message = "Oh,cool. New post arrived by #{self.user.name}: #{self.title} #{note_url(self)}"
    notify(message)
  end

  def comment_notify
    message = "Wow! New comment arrived by #{self.user.name}: #{self.note.title} #{note_url(self.note)}"
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
