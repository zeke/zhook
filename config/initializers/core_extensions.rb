require "cgi"
require "uri"

class Hash
  def to_like_conditions
    conditions = [self.keys.map{|k| "#{k} LIKE ?" }.join(" AND ")]
    conditions << self.values.map{|v| "%#{v}%" }
    conditions.flatten
  end
end

class String
  # remove middle from strings exceeding max length.
  def ellipsize(options={})
     max = options[:max] || 40
     delimiter = options[:delimiter] || "..."
     return self if self.size <= max
     offset = max/2
     self[0,offset] + delimiter + self[-offset,offset]
  end

  def domain
     self.split("//").last.split("/").first.downcase rescue "" # 'http://dog.com/x/y/z' becomes 'dog.com'
  end

  def sanitize_phone
    self.gsub(/[^0-9]/, "") # Remove everything but numbers
  end

  def strip_tags
    self.gsub(/<\/?[^>]*>/, "")
  end
  
  def add_http
    return "" if self.blank?
    "http://#{self}" unless self.starts_with?("http")
  end
  
  def absolute_url?
    self.starts_with? "http"
  end    
  
  def modulus_wrap
    "%#{self}%"
  end
  
  def valid_url?
    uri = URI.parse(self)
    return false if uri.class != URI::HTTP
    return true
  rescue URI::InvalidURIError
    return false
  end
  
  def cgi_escape
    CGI.escape(self)
  end

end