# This migration comes from inner_message (originally 20140815090716)
class CreateInnerMessageTalker < ActiveRecord::Migration
  def change
    create_table :inner_message_talkers do |t|
      t.string :type
      t.string :session_key
    end
  end
end
