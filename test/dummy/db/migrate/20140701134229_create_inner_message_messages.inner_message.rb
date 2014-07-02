# This migration comes from inner_message (originally 20140701120746)
class CreateInnerMessageMessages < ActiveRecord::Migration
  def change
    create_table :inner_message_messages do |t|
      t.text :text

      t.timestamps
    end
  end
end
