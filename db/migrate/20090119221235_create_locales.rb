class CreateLocales < ActiveRecord::Migration
  def self.up
    create_table :locales do |t|
      t.integer :zip
      t.float :latitude
      t.float :longitude
      t.string :city
      t.string :state
      t.string :county
      t.string :postal_type

      t.timestamps
    end
  end

  def self.down
    drop_table :locales
  end
end
