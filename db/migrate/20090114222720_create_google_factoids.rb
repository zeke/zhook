class CreateGoogleFactoids < ActiveRecord::Migration
  def self.up
    create_table :google_factoids do |t|
      t.string :organization_id
      t.string :website
      t.string :phone
      t.string :address
      t.string :source_url

      t.timestamps
    end
  end

  def self.down
    drop_table :google_factoids
  end
end
