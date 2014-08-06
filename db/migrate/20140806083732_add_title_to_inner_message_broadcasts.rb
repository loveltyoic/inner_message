class AddTitleToInnerMessageBroadcasts < ActiveRecord::Migration
  def change
    add_column :inner_message_broadcasts, :title, :string
  end
end
