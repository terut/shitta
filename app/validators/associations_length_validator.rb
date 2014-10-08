class AssociationsLengthValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    maximum = options[:length][:maximum]
    if maximum.present? && value.reject(&:marked_for_destruction?).size > maximum
      record.errors[attribute] << (options[:message] || "is too long (maximum is #{maximum})")
    end

    minimum = options[:length][:minimum]
    if minimum.present? && value.reject(&:marked_for_destruction?).size > minimum
      record.errors[attribute] << (options[:message] || "is too short (minimum is #{minimum})")
    end
  end
end
