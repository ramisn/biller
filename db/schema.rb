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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120314142603) do

  create_table "account_contacts", :force => true do |t|
    t.integer  "account_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "account_product_contexts", :force => true do |t|
    t.integer  "account_id"
    t.integer  "product_context_id"
    t.integer  "product_id",         :null => false
    t.float    "unit_price",         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "accounts", :force => true do |t|
    t.integer  "organization_id"
    t.string   "display_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "phone"
  end

  create_table "invoice_line_items", :force => true do |t|
    t.integer  "invoice_id"
    t.string   "name"
    t.float    "quantity"
    t.float    "unit_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoice_status_logs", :force => true do |t|
    t.integer  "invoice_id"
    t.integer  "invoice_status_id"
    t.integer  "created_by"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoice_statuses", :force => true do |t|
    t.string  "name"
    t.integer "priority"
  end

  create_table "invoices", :force => true do |t|
    t.integer  "organization_id"
    t.integer  "account_id"
    t.integer  "invoice_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "statuses"
    t.string   "tax"
    t.string   "total_amount"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "invoice_id"
    t.string   "name"
    t.float    "quantity"
    t.float    "unit_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_contexts", :force => true do |t|
    t.integer  "product_id"
    t.string   "product_type"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.float    "unit_price"
    t.text     "parameters"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "context_priority"
    t.string   "context_type"
  end

  create_table "products", :force => true do |t|
    t.integer  "organization_id"
    t.string   "name"
    t.float    "unit_price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "key",             :default => "", :null => false
    t.string   "description"
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.integer  "organization_id"
    t.string   "display_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
