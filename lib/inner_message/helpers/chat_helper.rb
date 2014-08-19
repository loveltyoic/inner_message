module InnerMessage
  module Helpers
    class Chat
      include ::ActionView::Context

      def initialize(template)
        @template = template
      end

      def to_s
        @template.render :partial => 'inner_message/chats/iframe'
      end
    end
  end
end