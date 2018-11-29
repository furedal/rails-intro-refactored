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

ActiveRecord::Schema.define(version: 2018_11_29_170430) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "restaurant_articles", force: :cascade do |t|
    t.bigint "restaurant_id"
    t.bigint "article_id"
    t.integer "selling_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_restaurant_articles_on_article_id"
    t.index ["restaurant_id"], name: "index_restaurant_articles_on_restaurant_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supplier_articles", force: :cascade do |t|
    t.bigint "article_id"
    t.bigint "supplier_id"
    t.integer "price"
    t.integer "art_nr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_supplier_articles_on_article_id"
    t.index ["supplier_id"], name: "index_supplier_articles_on_supplier_id"
  end

  create_table "supplier_restaurants", force: :cascade do |t|
    t.bigint "supplier_id"
    t.bigint "restaurant_id"
    t.integer "customer_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_supplier_restaurants_on_restaurant_id"
    t.index ["supplier_id"], name: "index_supplier_restaurants_on_supplier_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
