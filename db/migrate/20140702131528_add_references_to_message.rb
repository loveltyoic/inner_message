class AddReferencesToMessage < ActiveRecord::Migration
  def change
    add_column :inner_message_messages, :from_id, :integer
  end
end
