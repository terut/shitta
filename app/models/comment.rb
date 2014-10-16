class Comment < ActiveRecord::Base
  include Notifier

  belongs_to :note, counter_cache: true
  belongs_to :user

  validates :raw_body, presence: true

  after_create :comment_notify
end
