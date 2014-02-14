module ApplicationHelper
  class Pygmentize < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants

    def block_code(code, language)
      if language
        lang_and_title = language.split(":")
        language = find_language(lang_and_title[0])
        title = lang_and_title[1];
      end

      <<-EOS
        <div class="code-container">
          <div class="code-title">#{title.to_s}</div>
          #{highlight(code, language)}
        </div>
      EOS
    end

    def highlight(code, language)
      Pygments.highlight(code,
                         lexer: language,
                         options: { linenos: true, encoding: 'utf-8'})
    end

    private
    def find_language(lang)
      lexer = Pygments::Lexer.find(lang)
      unless lexer.blank?
        lexer.aliases.first
      else
        ""
      end
    end
  end

  def markdown(text)
    markdown = Redcarpet::Markdown.new(
      Pygmentize.new(filter_html: true, with_toc_data: true, hard_wrap: true),
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

  # css class name for js
  def js_css(class_name)
    "js-#{class_name}"
  end
end
