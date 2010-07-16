class CreateOrganizations < ActiveRecord::Migration
  def self.up
    create_table :organizations do |t|
      t.string :primary_name
      t.string :care_of_name
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :activity_codes
      t.string :ntee_code
      t.string :ein

      t.timestamps
    end
  end

  def self.down
    drop_table :organizations
  end
end
