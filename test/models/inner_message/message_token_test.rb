require 'test_helper'
module InnerMessage 
  describe MessageToken do
    let(:user) { InnerMessage.user_class.create }  

    it "should generate token" do
      MessageToken.generate(user.id)
      user.message_token.wont_be_nil
    end

  end
end
