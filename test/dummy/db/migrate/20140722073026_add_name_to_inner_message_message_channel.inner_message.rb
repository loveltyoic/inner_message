# This migration comes from inner_message (originally 20140722072736)
class AddNameToInnerMessageMessageChannel < ActiveRecord::Migration
  def change
    add_column :inner_message_message_channels, :name, :string
  end
end
