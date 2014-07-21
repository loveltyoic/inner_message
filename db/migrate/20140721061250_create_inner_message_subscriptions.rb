class CreateInnerMessageSubscriptions < ActiveRecord::Migration
  def change
    create_table :inner_message_subscriptions do |t|
      t.references :user
      t.references :message_channel
    end
  end
end
