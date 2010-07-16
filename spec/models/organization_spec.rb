require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Organization do
  before(:each) do
    @valid_attributes = {
      :primary_name => "value for primary_name",
      :care_of_name => "value for care_of_name",
      :street => "value for street",
      :city => "value for city",
      :state => "value for state",
      :zip => "value for zip",
      :activity_codes => "value for activity_codes",
      :ntee_code => "value for ntee_code",
      :ein => "value for ein"
    }
  end

  it "should create a new instance given valid attributes" do
    Organization.create!(@valid_attributes)
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