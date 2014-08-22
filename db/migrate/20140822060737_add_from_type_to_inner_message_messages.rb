class AddFromTypeToInnerMessageMessages < ActiveRecord::Migration
  def change
    add_column :inner_message_messages, :from_type, :string
  end
end
