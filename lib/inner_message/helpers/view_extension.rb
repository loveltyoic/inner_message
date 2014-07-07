module InnerMessage
  module ViewExtension
    def message_frame
      iframe = InnerMessage::Helpers::Iframe.new self
      iframe.to_s
    end
  end
end