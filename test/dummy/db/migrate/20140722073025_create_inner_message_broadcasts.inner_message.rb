# This migration comes from inner_message (originally 20140721134459)
class CreateInnerMessageBroadcasts < ActiveRecord::Migration
  def change
    create_table :inner_message_broadcasts do |t|
      t.text :content
      t.references :message_channel

      t.timestamps
    end
  end
end
