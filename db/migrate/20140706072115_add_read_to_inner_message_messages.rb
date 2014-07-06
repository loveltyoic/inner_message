class AddReadToInnerMessageMessages < ActiveRecord::Migration
  def change
    add_column :inner_message_messages, :read, :boolean, default: false
  end
end
