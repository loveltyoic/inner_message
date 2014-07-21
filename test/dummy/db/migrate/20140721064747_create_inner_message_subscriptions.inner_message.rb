# This migration comes from inner_message (originally 20140721061250)
class CreateInnerMessageSubscriptions < ActiveRecord::Migration
  def change
    create_table :inner_message_subscriptions do |t|
      t.references :user
      t.references :message_channel
    end
  end
end
