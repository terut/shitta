module TagParser
  def parse(tag_list)
    return [] if tag_list.blank?
    raws = compact(tag_list).split(delimiter)
    raws.map { |raw| raw.downcase unless raw.empty? }.uniq
  end

  private
  def delimiter
    ","
  end

  def compact(tag_list)
    tag_list.gsub(/[[:blank:]]/, "")
  end
end
