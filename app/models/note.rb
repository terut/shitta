class Note < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  validates :title, presence: true, length: { maximum: 250 }
  validates :raw_body, presence: true

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
