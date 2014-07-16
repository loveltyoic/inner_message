require "securerandom"

module InnerMessage
  class MessageToken
    include Mongoid::Document
    belongs_to :user, class_name: InnerMessage.user_class.to_s

    field :secret, type: String
    
    def self.generate(user_id)
      token = self.find_or_create_by(user_id: user_id)
      token.update(secret: SecureRandom.hex)
      token
    end

    def self.get_secret(user_id)
      token = self.find_by(user_id: user_id)
      token ? token.secret : 'anonymity'
    end
  end
end
