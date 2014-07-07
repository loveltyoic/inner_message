module InnerMessage
  module Helpers
    class Iframe
      include ::ActionView::Context

      def initialize(template)
        @template = template
      end

      def to_s
        @template.render :partial => 'inner_message/iframes/messages'
      end
    end
  end
end