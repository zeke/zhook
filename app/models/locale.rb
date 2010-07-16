class Locale < ActiveRecord::Base
  named_scope :county, lambda { |county| { :conditions => ["locales.county LIKE ?", county.modulus_wrap] } }
  named_scope :state, lambda { |state| { :conditions => ["locales.state LIKE ?", state.modulus_wrap] } }
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