# InnerMessage

An inner message system for rails app.

## Installation

Add this line to your application's Gemfile:

    gem 'inner_message'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install inner_message

## Webservers

Since ActionController::Live used in inner_message, the webserver should be either Rainbows!, Puma, or Thin. 

## Usage

1. rails g inner_message:config
2. rake inner_message:install:migrations
3. rake db:migrate
4. Update config/initializer/inner_message.rb with your app's config.
5. use `<%= message_frame %>` to embed a message iframe.
9. After user signed in, you should assign session[:current_user] to signed user's id, inner_message use this to bind user.
10. Now, in your app, user has ability to send and get messages.

## Example
```ruby
user.send_message({to_id: User.last.id, content: 'Wooha, I love ruby!'})
#get all messages
another_user.get_messages
#or get unread messages
another_user.get_messages.unread
```
