# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170125234422) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "diagnoses", force: :cascade do |t|
    t.string   "ICD_code"
    t.string   "diagnosis_name"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "durations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "length"
  end

  create_table "health_plans", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "deductible"
    t.integer  "virtual_visit"
    t.integer  "pcp"
    t.integer  "specialist"
    t.integer  "er"
    t.integer  "urgent_care"
    t.float    "co_insurance"
    t.integer  "out_of_pocket_max"
    t.integer  "inpatient_deductible"
    t.integer  "pharmacy_clinic"
  end

  create_table "health_systems", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.boolean  "er"
    t.boolean  "urgent_care"
    t.boolean  "pharmacy_clinic"
    t.boolean  "walk_in_clinic"
    t.boolean  "virtual_visit"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "medications", force: :cascade do |t|
    t.string   "RXCUI"
    t.string   "medication_name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.boolean  "read",            default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "plan_providers", force: :cascade do |t|
    t.integer  "health_plan_id"
    t.integer  "provider_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "providers", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "specialty"
    t.integer  "health_system_id"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "severities", force: :cascade do |t|
    t.integer  "intensity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "symptoms", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_diagnoses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "diagnosis_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "user_health_systems", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "health_system_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "user_medications", force: :cascade do |t|
    t.integer  "medication_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "user_providers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "provider_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "date_of_birth"
    t.integer  "age"
    t.string   "address"
    t.string   "phone_number"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "health_plan_id"
    t.string   "password_digest"
    t.boolean  "active"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "deductible"
    t.integer  "out_of_pocket_max"
    t.boolean  "nurse_navigator",   default: false
  end

end
