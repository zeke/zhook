class AddNotesToGoogleFactoidsForErrorMessages < ActiveRecord::Migration
  def self.up
    add_column :google_factoids, :notes, :string
  end

  def self.down
    remove_column :google_factoids, :notes
  end
end
