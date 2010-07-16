class CreateSiteFactoids < ActiveRecord::Migration
  def self.up
    create_table :site_factoids do |t|
      t.integer :organization_id
      t.string :kind
      t.string :content
      t.string :source_url
      t.boolean :fruitful, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :site_factoids
  end
end
