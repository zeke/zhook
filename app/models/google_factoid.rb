require 'mechanize'
require 'hpricot'

class GoogleFactoid < ActiveRecord::Base
  belongs_to :organization
  named_scope :fruitful, :conditions => {:fruitful => true}
  named_scope :fruitless, :conditions => {:fruitful => false}
  
  def fruitful?; fruitful; end
  def unfruitful?; !fruitful; end
  
  def phone_safe
    self.phone rescue ""
  end

  def website_safe
    self.website rescue ""
  end
  
  def address_safe
    self.address rescue ""
  end
  
  def street
    self.address_safe.split("\n").first
  end
  
  def city
    self.address_safe.split("\n").last.split(",").first
  end
  
  def state
    self.address_safe.split("\n").last.split(", ").last.split(" ").first
  end
  
  def zip
    self.address_safe.split(" ").last
  end  

end

# == Schema Info
# Schema version: 20090124015220
#
# Table name: google_factoids
#
#  id              :integer(4)      not null, primary key
#  organization_id :string(255)
#  address         :string(255)
#  fruitful        :boolean(1)
#  notes           :string(255)
#  phone           :string(255)
#  source_url      :string(255)
#  website         :string(255)
#  created_at      :datetime
#  updated_at      :datetime