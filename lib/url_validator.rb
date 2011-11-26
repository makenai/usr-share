# lib/url_validator.rb
class UrlValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    uri = URI.parse(value)
    unless ( uri.kind_of?(URI::HTTP) || uri.kind_of?(URI::HTTPS) ) && uri.host.present? && uri.host.match(/\./)
      record.errors[attribute] << (options[:message] || "is not valid")
    end
  rescue 
    record.errors[attribute] << (options[:message] || "is not valid")
  end

end