module InnerMessage
  module IframeHelper
    include ::ActionView::Context
    def message_frame
      tag("iframe", frameborder: '0', height: '300', width: '300', src: '/inner_message/iframe')
    end
  end
end