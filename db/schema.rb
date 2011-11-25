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

ActiveRecord::Schema.define(:version => 20111125111148) do

  create_table "comments", :force => true do |t|
    t.text     "comment"
    t.string   "author"
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "email"
  end

  create_table "commissions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "commissions_initiatives", :id => false, :force => true do |t|
    t.integer "commission_id"
    t.integer "initiative_id"
  end

  create_table "initiatives", :force => true do |t|
    t.datetime "presented_at"
    t.text     "description"
    t.text     "title"
    t.string   "presented_by"
    t.text     "additional_resources"
    t.string   "additional_resources_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.integer  "official_vote_up",          :default => 0
    t.integer  "official_vote_down",        :default => 0
    t.integer  "representative_id"
    t.boolean  "main"
    t.integer  "political_party_id"
    t.datetime "voted_at"
    t.integer  "official_vote_abstentions"
  end

  create_table "initiatives_topics", :id => false, :force => true do |t|
    t.integer "initiative_id"
    t.integer "topic_id"
  end

  create_table "political_parties", :force => true do |t|
    t.string   "name"
    t.string   "logo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "provinces", :force => true do |t|
    t.string   "name"
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "representatives", :force => true do |t|
    t.string   "name"
    t.string   "position"
    t.integer  "region_id"
    t.integer  "province_id"
    t.string   "avatar"
    t.text     "biography"
    t.string   "birthday"
    t.string   "twitter"
    t.string   "facebook"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "political_party_id"
    t.string   "district"
    t.string   "phone"
    t.string   "email"
    t.string   "substitute"
    t.string   "election_type"
    t.string   "commissions"
  end

  create_table "topics", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", :force => true do |t|
    t.integer  "vote"
    t.integer  "initiative_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
