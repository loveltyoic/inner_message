module InnerMessage
  module ViewHelper
    def message_frame
      tag("iframe", frameborder: '0', width: '320', height: '400', src: '/inner_message/iframe')
    end
  end
end