# This migration comes from inner_message (originally 20140701120746)
class CreateInnerMessageMessages < ActiveRecord::Migration
  def change
    create_table :inner_message_messages do |t|
      t.text :content
      t.integer :to_id
      t.integer :from_id
      t.references :messageable, polymorphic: true

      t.timestamps
    end
  end
end
