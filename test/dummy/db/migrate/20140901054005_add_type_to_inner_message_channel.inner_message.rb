# This migration comes from inner_message (originally 20140901053807)
class AddTypeToInnerMessageChannel < ActiveRecord::Migration
  def change
    add_column :inner_message_channels, :type, :string
  end
end
