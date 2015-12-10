# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151210144801) do

  create_table "barcards", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "boats", force: :cascade do |t|
    t.integer  "member_id",                                         null: false
    t.string   "boat_name",   limit: 255
    t.string   "boat_type",   limit: 255
    t.string   "boat_class",  limit: 255
    t.string   "sail_number", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pen_tag",     limit: 255, default: "None Assigned"
  end

  add_index "boats", ["member_id"], name: "BoatsMembers"

  create_table "loyaltycards", force: :cascade do |t|
    t.string   "Member Title",            limit: 16
    t.string   "Member Forename",         limit: 64
    t.string   "Member Middlenames",      limit: 64
    t.string   "Member Surname",          limit: 64
    t.string   "Address 1",               limit: 128
    t.string   "Address 2",               limit: 128
    t.string   "Address 3",               limit: 128
    t.string   "Town City",               limit: 128
    t.string   "County",                  limit: 128
    t.string   "Post Code",               limit: 32
    t.string   "Home Telephone",          limit: 64
    t.string   "Work Telephone",          limit: 64
    t.string   "Mobile Telephone",        limit: 64
    t.string   "Company Name",            limit: 64
    t.date     "Date Of Birth"
    t.string   "Gender",                  limit: 2
    t.integer  "Cards Issued TD"
    t.integer  "Age"
    t.integer  "Scheme Code"
    t.string   "Data Protection Flag",    limit: 1
    t.integer  "Link Member Code"
    t.date     "Date Registered"
    t.float    "Points Claimed"
    t.float    "Average Points Claimed"
    t.integer  "RedeemedTD"
    t.integer  "Current Points"
    t.integer  "Total Points Issued"
    t.float    "Average Points Issued"
    t.integer  "IssuedTD"
    t.float    "Total Spend"
    t.float    "Average Spend"
    t.integer  "Loyalty Transactions TD"
    t.date     "Date Of Last Trans"
    t.date     "Date Of Last Redemption"
    t.date     "Date Of Last Issue"
    t.integer  "Admissions"
    t.date     "Last Admission"
    t.integer  "Declined"
    t.date     "Last Declined"
    t.string   "PicFilePath",             limit: 510
    t.date     "LastContactedDate"
    t.string   "Status",                  limit: 100
    t.string   "EMail",                   limit: 510
    t.integer  "DOBD"
    t.string   "Scheme Changed",          limit: 1
    t.string   "INTFlag",                 limit: 1
    t.integer  "SEREAL NUMBER"
    t.string   "Membership Type",         limit: 128
    t.date     "Last Renewal Date"
    t.integer  "Member Code"
    t.string   "Rewnewed 2009",           limit: 1
    t.date     "Renewed Date"
    t.date     "Renewed 2008"
    t.string   "Bar Billies",             limit: 1
    t.string   "Saluation",               limit: 510
    t.string   "House Name No",           limit: 510
    t.string   "Occupation",              limit: 510
    t.string   "Social",                  limit: 510
    t.string   "Racing",                  limit: 510
    t.string   "Cruser",                  limit: 510
    t.string   "Dinghy",                  limit: 510
    t.string   "Junor",                   limit: 510
    t.string   "City",                    limit: 510
    t.string   "Country",                 limit: 510
    t.integer  "MerberShipId"
    t.datetime "updated_at",                          null: false
  end

  create_table "members", force: :cascade do |t|
    t.string   "address1",      limit: 255
    t.string   "address2",      limit: 255
    t.string   "address3",      limit: 255
    t.string   "address4",      limit: 255
    t.string   "proposed",      limit: 255
    t.string   "seconded",      limit: 255
    t.integer  "year_joined"
    t.string   "occupation",    limit: 255
    t.datetime "renew_date"
    t.integer  "privilege_id",                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name_no",       limit: 255
    t.string   "street1",       limit: 255
    t.string   "street2",       limit: 255
    t.string   "town",          limit: 255
    t.string   "city",          limit: 255
    t.string   "postcode",      limit: 255
    t.string   "county",        limit: 255
    t.string   "country",       limit: 255
    t.integer  "email_renewal", limit: 1,   default: 0, null: false
    t.integer  "active",        limit: 1,   default: 1, null: false
  end

  add_index "members", ["privilege_id"], name: "priv"
  add_index "members", ["renew_date"], name: "MemRenew"

  create_table "payment_methods", force: :cascade do |t|
    t.string   "name",       limit: 40, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "member_id",                                    null: false
    t.decimal  "amount",                        precision: 10
    t.datetime "date_lodged"
    t.string   "pay_type",          limit: 255
    t.string   "comment",           limit: 255
    t.integer  "privilege_id",                                 null: false
    t.integer  "paymenttype_id",                               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "payment_method_id"
  end

  add_index "payments", ["date_lodged"], name: "paymentsdate"
  add_index "payments", ["member_id"], name: "PayMembers"

  create_table "paymenttypes", force: :cascade do |t|
    t.string   "name",       limit: 40, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: :cascade do |t|
    t.integer  "member_id",                                        null: false
    t.string   "first_name",               limit: 255
    t.string   "last_name",                limit: 255
    t.string   "status",                   limit: 255
    t.string   "child_dob",                limit: 255
    t.string   "home_phone",               limit: 255
    t.string   "mobile_phone",             limit: 255
    t.string   "email_address",            limit: 255
    t.string   "comm_prefs",               limit: 255
    t.string   "snd_txt",                  limit: 255
    t.string   "snd_eml",                  limit: 255
    t.date     "dob"
    t.integer  "member_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "txt_bridge",               limit: 1,   default: 0, null: false
    t.integer  "txt_social",               limit: 1,   default: 0, null: false
    t.integer  "txt_crace",                limit: 1,   default: 0, null: false
    t.integer  "txt_cruiser_race_skipper", limit: 1,   default: 0, null: false
    t.integer  "txt_cruising",             limit: 1,   default: 0, null: false
    t.integer  "txt_cruiser_skipper",      limit: 1,   default: 0, null: false
    t.integer  "txt_dinghy_sailing",       limit: 1,   default: 0, null: false
    t.integer  "txt_junior",               limit: 1,   default: 0, null: false
    t.integer  "txt_test",                 limit: 1,   default: 0, null: false
    t.integer  "txt_op_co",                limit: 1,   default: 0, null: false
    t.string   "occupation",               limit: 255
    t.integer  "send_txt",                 limit: 1,   default: 0
    t.integer  "send_email",               limit: 1,   default: 0
    t.integer  "txt_dev",                  limit: 1,   default: 0, null: false
  end

  add_index "people", ["member_id"], name: "PeoMembers"

  create_table "peoplebarcards", force: :cascade do |t|
    t.integer  "person_id",  null: false
    t.integer  "barcard_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "peoplebarcards", ["barcard_id"], name: "i_peoplebarcards_barcards"
  add_index "peoplebarcards", ["person_id"], name: "i_peoplebarcards_people"

  create_table "privileges", force: :cascade do |t|
    t.string   "member_class",  limit: 1,                null: false
    t.string   "name",          limit: 50,               null: false
    t.string   "bar_billies",   limit: 1,  default: "N", null: false
    t.integer  "car_park",                 default: 0,   null: false
    t.integer  "votes",                    default: 0,   null: false
    t.integer  "bar_reference",            default: 0,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "boat_storage",  limit: 2,  default: 0,   null: false
  end

  create_table "renewals", force: :cascade do |t|
    t.string   "subject",      limit: 255
    t.text     "content"
    t.datetime "delivered_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "requested_at"
  end

  create_table "schema_info", id: false, force: :cascade do |t|
    t.integer "version"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.float    "amount",       null: false
    t.date     "start_date",   null: false
    t.date     "end_date",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "privilege_id", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.boolean  "admin",                              default: false
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "versions", force: :cascade do |t|
    t.integer  "versioned_id"
    t.string   "versioned_type", limit: 255
    t.integer  "user_id"
    t.string   "user_type",      limit: 255
    t.string   "user_name",      limit: 255
    t.text     "modifications"
    t.integer  "number"
    t.integer  "reverted_from"
    t.string   "tag",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
