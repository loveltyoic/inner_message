require 'test_helper'
module InnerMessage 
  describe MessageToken do
    let(:user) { InnerMessage.user_class.create }  

    it "should generate token" do
      MessageToken.generate(user.id)
      user.message_token.wont_be_nil
    end

    it "should get token by user id" do
      token = MessageToken.generate(user.id)
      MessageToken.get_secret(user.id).must_equal token.secret
    end

    it "should return anonymity if user has no token yet" do 
      user = InnerMessage.user_class.create
      MessageToken.get_secret(user.id).must_equal 'anonymity'
    end

  end
end
