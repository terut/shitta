module TagParser
  def parse(tag_list)
    return [] if tag_list.blank?
    compact(tag_list).split(delimiter).reject(&:empty?)
  end

  private
  def delimiter
    ","
  end

  def compact(tag_list)
    tag_list.gsub(/[[:blank:]]/, "")
  end
end
