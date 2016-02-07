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

ActiveRecord::Schema.define(version: 20160207030521) do

  create_table "transactions", force: :cascade do |t|
    t.string   "account_number"
    t.datetime "posted_at"
    t.datetime "transaction_at"
    t.text     "category"
    t.text     "merchant_name"
    t.text     "merchant_city"
    t.text     "merchant_state"
    t.text     "description"
    t.text     "transaction_type"
    t.decimal  "amount",           precision: 7, scale: 2
    t.text     "reference"
  end

end
