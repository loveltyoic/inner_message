# This migration comes from inner_message (originally 20140806083732)
class AddTitleToInnerMessageBroadcasts < ActiveRecord::Migration
  def change
    add_column :inner_message_broadcasts, :title, :string
  end
end
