class Player < ActiveRecord::Base
  include InnerMessage::Messager
end
