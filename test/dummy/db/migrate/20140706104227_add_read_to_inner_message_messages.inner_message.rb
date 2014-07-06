# This migration comes from inner_message (originally 20140706072115)
class AddReadToInnerMessageMessages < ActiveRecord::Migration
  def change
    add_column :inner_message_messages, :read, :boolean, default: false
  end
end
