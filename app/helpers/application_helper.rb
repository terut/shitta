module ApplicationHelper
  class Pygmentize < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants

    def block_code(code, language)
      <<-EOS
        <div class="code-container">
          <div class="code-title">hogehoge</div>
          #{highlight(code, language)}
        </div>
      EOS
    end

    def highlight(code, language)
      Pygments.highlight(code,
                         lexer: language,
                         options: { linenos: true, encoding: 'utf-8'})
    end
  end

  def markdown(text)
    markdown = Redcarpet::Markdown.new(
      Pygmentize.new(filter_html: true, hard_wrap: true),
      no_intra_emphasis: true,
      tables: true,
      fenced_code_blocks: true,
      autolink: true,
      strikethrough: true,
      lax_spacing: true,
      space_after_headers: true,
      superscript: true
    )
    markdown.render(text).html_safe
  end
end
