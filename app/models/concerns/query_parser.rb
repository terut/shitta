require 'shellwords'
module QueryParser
  def self.parse(query)
    return [] if query.blank?
    words = Shellwords.split(escape(query).gsub(/　+/, ' '))
    words.map { |word| escape(word) }
  end

  private
  def self.escape(word)
    word.gsub(/[\\%_]/){ |m| "\\#{m}" }
  end
end
