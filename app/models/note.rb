class Note < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  attr_accessible :raw_body, :title

  validates :title, presence: true, length: { maximum: 250 }
  validates :raw_body, presence: true

  def share(user)
    return false unless user.connected?

    qiita = Qiita.new token: user.service_token
    item = { title: self.title,
             body: self.raw_body,
             #tags: [{ name: 'ruby', versions: %w[1.9.3 2.0.0] }],
             tags: [{ name: 'ruby' }],
             private: true }
    if self.shared?
      body = qiita.update_item self.uuid, item
    else
      body = qiita.post_item item
    end

    self.uuid = body['uuid']
    self.save
  rescue
    false
  end

  def shared?
    !!self.uuid
  end
end
