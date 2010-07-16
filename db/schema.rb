# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090124015220) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.string   "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "google_factoids", :force => true do |t|
    t.string   "organization_id"
    t.string   "website"
    t.string   "phone"
    t.string   "address"
    t.string   "source_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "fruitful",        :default => false
    t.string   "notes"
  end

  create_table "locales", :force => true do |t|
    t.integer  "zip"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "city"
    t.string   "state"
    t.string   "county"
    t.string   "postal_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", :force => true do |t|
    t.string   "primary_name"
    t.string   "care_of_name"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "activity_codes"
    t.string   "ntee_code"
    t.string   "ein"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_factoids", :force => true do |t|
    t.integer  "organization_id"
    t.string   "kind"
    t.string   "content"
    t.string   "source_url"
    t.boolean  "fruitful",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
