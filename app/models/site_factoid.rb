class SiteFactoid < ActiveRecord::Base
  belongs_to :organization
  named_scope :fruitful, :conditions => {:fruitful => true}
  named_scope :fruitless, :conditions => {:fruitful => false}
  
  def fruitful?; fruitful; end
  def unfruitful?; !fruitful; end

  def email?; self.kind == "email"; end  
  def phone?; self.kind == "phone"; end
  
  def email_only
    self.content.split(": ").last.split("?").first
  end

end


# == Schema Info
# Schema version: 20090124015220
#
# Table name: site_factoids
#
#  id              :integer(4)      not null, primary key
#  organization_id :integer(4)
#  content         :string(255)
#  fruitful        :boolean(1)
#  kind            :string(255)
#  source_url      :string(255)
#  created_at      :datetime
#  updated_at      :datetime