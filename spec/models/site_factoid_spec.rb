require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SiteFactoid do
  before(:each) do
    @valid_attributes = {
      :organization_id => 1,
      :kind => "value for kind",
      :content => "value for content",
      :source_url => "value for source_url",
      :fruitful => false
    }
  end

  it "should create a new instance given valid attributes" do
    SiteFactoid.create!(@valid_attributes)
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