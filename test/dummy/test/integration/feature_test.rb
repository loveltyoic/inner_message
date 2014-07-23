require 'test_helper'

class FeatureTest < ActionDispatch::IntegrationTest
  test 'visit root' do
    skip

    visit('/')
    assert_selector 'iframe'
  end

  test 'add unread message count' do 
    skip

    visit('/')
    visit('/inner_message/iframe')
    # save_and_open_screenshot
    old_count = find('.badge').text.to_i
    visit('/')
    click_button('submit')
    visit('/inner_message/iframe')
    count_badge = find('.badge')
    count_badge.assert_text (old_count + 1).to_s
    count_badge.click
    first('.message').click
    count_badge.assert_text old_count.to_s
  end
end