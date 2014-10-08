class Note < ActiveRecord::Base
  include Notifier
  include TagParser

  belongs_to :user
  has_many :comments
  has_many :favorites
  has_many :favorited_users, through: :favorites
  has_many :taggings
  has_many :tags, through: :taggings, autosave: true

  validates :title, presence: true, length: { maximum: 250 }
  validates :raw_body, presence: true
  validates :tags, associations_length: { length: { maximum: 5 } }

  scope :latest, lambda { order(created_at: :desc) }

  after_create :post_notify

  def tag_list=(tag_list)
    tag_names = parse(tag_list)
    removal_marked(tag_names)

    old_tags = self.tags.map(&:name)

    exists_tags = Tag.where(name: tag_names)
    exists_tags.each do |tag|
      self.tags << tag unless old_tags.include?(tag.name)
      tag_names.delete(tag.name)
    end

    tag_names.each do |tag_name|
      self.tags.build(name: tag_name) unless old_tags.include?(tag_name)
    end
  end

  def tag_list
    if self.tags.blank?
      self.tags.pluck(:name).join(delimiter)
    else
      self.tags.map(&:name).join(delimiter)
    end
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

  def removal_marked(tag_names)
    self.tags.each do |tag|
      tag.mark_for_destruction unless tag_names.include?(tag.name)
    end
  end
end
