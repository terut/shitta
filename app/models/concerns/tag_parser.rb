module TagParser
  def parse(tag_list)
    return [] if tag_list.blank?
    tag_list.split(delimiter).reject(&:empty?)
  end

  private
  def delimiter
    /[[:blank:]]/
  end
end
