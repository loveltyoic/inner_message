class AddTypeToInnerMessageChannel < ActiveRecord::Migration
  def change
    add_column :inner_message_channels, :type, :string
  end
end
