require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GoogleFactoid do
  before(:each) do
    @valid_attributes = {
      :ein => "value for ein",
      :website => "value for website",
      :phone => "value for phone",
      :address => "value for address",
      :source_url => "value for source_url"
    }
  end

  it "should create a new instance given valid attributes" do
    GoogleFactoid.create!(@valid_attributes)
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