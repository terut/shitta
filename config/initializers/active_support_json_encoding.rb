module ActiveSupport
  module JSON
    module Encoding
      class << self
        def escape_with_utf8mb4(string)
          string = string.encode(::Encoding::UTF_8, :undef => :replace).force_encoding(::Encoding::BINARY)
          json = string.
            gsub(escape_regex) { |s| ESCAPED_CHARS[s] }.
            gsub(/([\xC0-\xDF][\x80-\xBF]|
[\xE0-\xEF][\x80-\xBF]{2}|
[\xF0-\xF7][\x80-\xBF]{3})+/nx) { |s|
              s = s.encode('utf-16be', 'utf-8')
              s.unpack("H*")[0].gsub(/.{4}/n, '\\\\u\&')
          }
          json = %("#{json}")
          json.force_encoding(::Encoding::UTF_8)
          json
        end
        alias_method_chain :escape, :utf8mb4
      end
    end
  end
end
