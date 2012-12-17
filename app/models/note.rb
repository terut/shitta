class Note < ActiveRecord::Base
  belongs_to :user
  attr_accessible :raw_body, :title

  def body
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                       autolink: true, space_after_headers: true)
    markdown.render(self.raw_body).html_safe
  end
end
