# This migration comes from inner_message (originally 20140714122358)
class CreateInnerMessageMessageTokens < ActiveRecord::Migration
  def change
    create_table :inner_message_message_tokens do |t|
      t.references :user
      t.string :secret

      t.timestamps
    end
  end
end
