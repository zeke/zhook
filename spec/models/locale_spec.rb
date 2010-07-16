require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Locale do
  before(:each) do
    @valid_attributes = {
      :zip => 1,
      :latitude => 1.5,
      :longitude => 1.5,
      :city => "value for city",
      :state => "value for state",
      :county => "value for county",
      :postal_type => "value for postal_type"
    }
  end

  it "should create a new instance given valid attributes" do
    Locale.create!(@valid_attributes)
  end
end


# == Schema Info
# Schema version: 20090124015220
#
# Table name: locales
#
#  id          :integer(4)      not null, primary key
#  city        :string(255)
#  county      :string(255)
#  latitude    :float
#  longitude   :float
#  postal_type :string(255)
#  state       :string(255)
#  zip         :integer(4)
#  created_at  :datetime
#  updated_at  :datetime