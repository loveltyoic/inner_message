class AddNameToInnerMessageMessageChannel < ActiveRecord::Migration
  def change
    add_column :inner_message_message_channels, :name, :string
  end
end
