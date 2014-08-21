# This migration comes from inner_message (originally 20140821060811)
class CreateTables < ActiveRecord::Migration
  def change
    create_table "inner_message_broadcasts", force: true do |t|
      t.text     "content"
      t.integer  "channel_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "title"
    end

    create_table "inner_message_channels", force: true do |t|
      t.string "name"
    end

    create_table "inner_message_messages", force: true do |t|
      t.text     "content"
      t.integer  "to_id"
      t.integer  "from_id"
      t.integer  "messageable_id"
      t.string   "messageable_type"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "read",             default: false
    end

    create_table "inner_message_subscriptions", force: true do |t|
      t.integer "user_id"
      t.integer "channel_id"
    end

    create_table "inner_message_talkers", force: true do |t|
      t.string "type"
      t.string "session_key"
      t.integer "user_id"
    end
  end
end
