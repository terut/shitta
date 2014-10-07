class Note < ActiveRecord::Base
  include Notifier
  include TagParser

  belongs_to :user
  has_many :comments
  has_many :favorites
  has_many :favorited_users, through: :favorites
  has_many :taggings
  has_many :tags, through: :taggings

  validates :title, presence: true, length: { maximum: 250 }
  validates :raw_body, presence: true

  scope :latest, lambda { order(created_at: :desc) }

  after_create :post_notify

  def tag_list=(tag_list)
    tag_names = parse(tag_list)
    tag_names.each do |tag_name|
      self.tags.build(name: tag_name)
    end
  end

  def tag_list
    self.tags.pluck(:name).join(delimiter)
  end

  def share(user)
    return false unless user.connected?

    qiita = Qiita.new token: user.service_token
    if shared?
      body = qiita.update_item self.uuid, shared_items
    else
      body = qiita.post_item shared_items
    end

    self.uuid = body['uuid']
    save
  rescue
    false
  end

  def shared?
    !!self.uuid
  end

  private
  def shared_items
    { title: self.title,
      body: self.raw_body,
      #tags: [{ name: 'ruby', versions: %w[1.9.3 2.0.0] }],
      tags: [{ name: 'ruby' }],
      private: true }
  end
end
