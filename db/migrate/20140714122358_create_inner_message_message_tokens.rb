class CreateInnerMessageMessageTokens < ActiveRecord::Migration
  def change
    create_table :inner_message_message_tokens do |t|
      t.references :user
      t.string :secret

      t.timestamps
    end
  end
end
