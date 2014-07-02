class CreateInnerMessageMessages < ActiveRecord::Migration
  def change
    create_table :inner_message_messages do |t|
      t.text :content
      t.string :to
      t.references :message_box

      t.timestamps
    end
  end
end
