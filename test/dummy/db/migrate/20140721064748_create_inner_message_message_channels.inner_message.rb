# This migration comes from inner_message (originally 20140721064650)
class CreateInnerMessageMessageChannels < ActiveRecord::Migration
  def change
    create_table :inner_message_message_channels do |t|
    end
  end
end
