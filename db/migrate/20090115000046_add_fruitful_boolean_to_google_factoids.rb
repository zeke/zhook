class AddFruitfulBooleanToGoogleFactoids < ActiveRecord::Migration
  def self.up
    add_column :google_factoids, :fruitful, :boolean, :default => false
  end

  def self.down
    remove_column :google_factoids, :fruitful
  end
end
