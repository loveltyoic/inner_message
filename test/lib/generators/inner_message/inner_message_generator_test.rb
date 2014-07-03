require 'test_helper'
require 'generators/inner_message/inner_message_generator'

module InnerMessage
  class InnerMessageGeneratorTest < Rails::Generators::TestCase
    tests InnerMessageGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
