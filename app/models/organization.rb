class Organization < ActiveRecord::Base
  has_many :google_factoids
  has_many :site_factoids
  # named_scope :in_zip, lambda { |zip| { :conditions => ['organizations.zip = ?', zip] } }
  # named_scope :any, :conditions => ["1=1"]
  # named_scope :fruitful, :conditions => {:fruitful => true}

  def name
    self.primary_name.titlecase rescue "(blank)"
  end
    
  def to_param
    self.ein
  end
  
  def address(delimiter=" ")
    "#{self.street.titlecase}#{delimiter}#{self.city.titlecase}, #{self.state} #{self.zip}"
  end
  
  def website
    self.google_factoids.fruitful.last.website rescue ""
  end
  
  # Google
  def find_on_google
    crawler = GoogleCrawler.new
    crawler.find_organization(self.id)
  end
  
  def has_been_googled?; !self.google_factoids.empty? end  
  def has_not_been_googled?; !self.has_been_googled? end
  def has_been_googled_and_no_dice?
    return false unless self.has_been_googled?
    self.google_factoids.last.unfruitful?
  end
  
  # Site 
  def has_had_site_searched?; !self.site_factoids.empty? end
  def has_not_had_site_searched?; !self.has_had_site_searched? end
  def has_had_site_searched_and_no_dice?
    return false unless self.has_had_site_searched?
    self.site_factoids.last.unfruitful?
  end
    
end

# == Schema Info
# Schema version: 20090124015220
#
# Table name: organizations
#
#  id             :integer(4)      not null, primary key
#  activity_codes :string(255)
#  care_of_name   :string(255)
#  city           :string(255)
#  ein            :string(255)
#  ntee_code      :string(255)
#  primary_name   :string(255)
#  state          :string(255)
#  street         :string(255)
#  zip            :string(255)
#  created_at     :datetime
#  updated_at     :datetime