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

ActiveRecord::Schema.define(version: 20141121090103) do

  create_table "barcards", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "boats", force: true do |t|
    t.integer  "member_id",                             null: false
    t.string   "boat_name"
    t.string   "boat_type"
    t.string   "boat_class"
    t.string   "sail_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pen_tag",     default: "None Assigned"
  end

  add_index "boats", ["member_id"], name: "BoatsMembers", using: :btree

  create_table "loyaltycards", force: true do |t|
    t.string   "Member_Title",            limit: 16
    t.string   "Member_Forename",         limit: 64
    t.string   "Member_Middlenames",      limit: 64
    t.string   "Member_Surname",          limit: 64
    t.string   "Address_1",               limit: 128
    t.string   "Address_2",               limit: 128
    t.string   "Address_3",               limit: 128
    t.string   "Town_City",               limit: 128
    t.string   "County",                  limit: 128
    t.string   "Post_Code",               limit: 32
    t.string   "Home_Telephone",          limit: 64
    t.string   "Work_Telephone",          limit: 64
    t.string   "Mobile_Telephone",        limit: 64
    t.string   "Company_Name",            limit: 64
    t.date     "Date_Of_Birth"
    t.string   "Gender",                  limit: 2
    t.integer  "Cards_Issued_TD"
    t.integer  "Age"
    t.integer  "Scheme_Code"
    t.string   "Data_Protection_Flag",    limit: 1
    t.integer  "Link_Member_Code"
    t.date     "Date_Registered"
    t.float    "Points_Claimed"
    t.float    "Average_Points_Claimed"
    t.integer  "RedeemedTD"
    t.integer  "Current_Points"
    t.integer  "Total_Points_Issued"
    t.float    "Average_Points_Issued"
    t.integer  "IssuedTD"
    t.float    "Total_Spend"
    t.float    "Average_Spend"
    t.integer  "Loyalty_Transactions_TD"
    t.date     "Date_Of_Last_Trans"
    t.date     "Date_Of_Last_Redemption"
    t.date     "Date_Of_Last_Issue"
    t.integer  "Admissions"
    t.date     "Last_Admission"
    t.integer  "Declined"
    t.date     "Last_Declined"
    t.string   "PicFilePath",             limit: 510
    t.date     "LastContactedDate"
    t.string   "Status",                  limit: 100
    t.string   "EMail",                   limit: 510
    t.integer  "DOBD"
    t.string   "Scheme_Changed",          limit: 1
    t.string   "INTFlag",                 limit: 1
    t.integer  "SEREAL_NUMBER"
    t.string   "Membership_Type",         limit: 128
    t.date     "Last_Renewal_Date"
    t.integer  "Member_Code"
    t.string   "Rewnewed_2009",           limit: 1
    t.date     "Renewed_Date"
    t.date     "Renewed_2008"
    t.string   "Bar_Billies",             limit: 1
    t.string   "Saluation",               limit: 510
    t.string   "House_Name_No",           limit: 510
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

  create_table "members", force: true do |t|
    t.string   "address1"
    t.string   "address2"
    t.string   "address3"
    t.string   "address4"
    t.string   "proposed"
    t.string   "seconded"
    t.integer  "year_joined"
    t.string   "occupation"
    t.datetime "renew_date"
    t.integer  "privilege_id",                               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name_no"
    t.string   "street1"
    t.string   "street2"
    t.string   "town"
    t.string   "city"
    t.string   "postcode"
    t.string   "county"
    t.string   "country"
    t.string   "email_renewal", limit: 1, default: "N",      null: false
    t.string   "status",                  default: "Active", null: false
  end

  add_index "members", ["privilege_id"], name: "priv", using: :btree
  add_index "members", ["renew_date"], name: "MemRenew", using: :btree
  add_index "members", ["status"], name: "index_members_on_status", using: :btree

  create_table "payment_methods", force: true do |t|
    t.string   "name",       limit: 40, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.integer  "member_id",                                  null: false
    t.decimal  "amount",            precision: 10, scale: 0
    t.datetime "date_lodged"
    t.string   "pay_type"
    t.string   "comment"
    t.integer  "privilege_id",                               null: false
    t.integer  "paymenttype_id",                             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "payment_method_id"
  end

  add_index "payments", ["date_lodged"], name: "Date", using: :btree
  add_index "payments", ["member_id"], name: "PayMembers", using: :btree

  create_table "paymenttypes", force: true do |t|
    t.string   "name",       limit: 40, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: true do |t|
    t.integer  "member_id",                                      null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "status"
    t.string   "child_dob"
    t.string   "home_phone"
    t.string   "mobile_phone"
    t.string   "email_address"
    t.string   "comm_prefs"
    t.string   "snd_txt"
    t.string   "snd_eml"
    t.date     "dob"
    t.integer  "member_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "txt_bridge",               limit: 1, default: 0, null: false
    t.integer  "txt_social",               limit: 1, default: 0, null: false
    t.integer  "txt_crace",                limit: 1, default: 0, null: false
    t.integer  "txt_cruiser_race_skipper", limit: 1, default: 0, null: false
    t.integer  "txt_cruising",             limit: 1, default: 0, null: false
    t.integer  "txt_cruiser_skipper",      limit: 1, default: 0, null: false
    t.integer  "txt_dinghy_sailing",       limit: 1, default: 0, null: false
    t.integer  "txt_junior",               limit: 1, default: 0, null: false
    t.integer  "txt_test",                 limit: 1, default: 0, null: false
    t.integer  "txt_op_co",                limit: 1, default: 0, null: false
    t.string   "occupation"
    t.integer  "send_txt",                 limit: 1, default: 0, null: false
    t.integer  "send_email",               limit: 1, default: 0, null: false
  end

  add_index "people", ["member_id"], name: "PeoMembers", using: :btree

  create_table "peoplebarcards", force: true do |t|
    t.integer  "person_id",  null: false
    t.integer  "barcard_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "peoplebarcards", ["barcard_id"], name: "peoplebarcards_barcards", using: :btree
  add_index "peoplebarcards", ["person_id"], name: "peoplebarcards_people", using: :btree

  create_table "privileges", force: true do |t|
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

  create_table "renewals", force: true do |t|
    t.string   "subject"
    t.text     "content"
    t.datetime "delivered_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "requested_at"
  end

  create_table "subscriptions", force: true do |t|
    t.float    "amount",       null: false
    t.datetime "start_date",   null: false
    t.datetime "end_date",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "privilege_id", null: false
  end

  create_table "transactions", force: true do |t|
    t.integer  "member_id"
    t.decimal  "amount",            precision: 10, scale: 0
    t.datetime "date_lodged"
    t.string   "pay_type"
    t.string   "comment"
    t.integer  "privilege_id"
    t.integer  "paymenttype_id"
    t.integer  "payment_method_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.integer  "versioned_id"
    t.string   "versioned_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "user_name"
    t.text     "modifications"
    t.integer  "number"
    t.integer  "reverted_from"
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
