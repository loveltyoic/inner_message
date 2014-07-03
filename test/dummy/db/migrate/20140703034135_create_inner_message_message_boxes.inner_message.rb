# This migration comes from inner_message (originally 20140702115707)
class CreateInnerMessageMessageBoxes < ActiveRecord::Migration
  def change
    create_table :inner_message_message_boxes do |t|
      t.references :user

      t.timestamps
    end
  end
end
