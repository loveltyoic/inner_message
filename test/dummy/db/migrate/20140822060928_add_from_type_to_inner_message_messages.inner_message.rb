# This migration comes from inner_message (originally 20140822060737)
class AddFromTypeToInnerMessageMessages < ActiveRecord::Migration
  def change
    add_column :inner_message_messages, :from_type, :string
  end
end
