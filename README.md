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
5. you could embed a message box provided by view helper, you could place it in your layout.
in your application_helper.rb file, `include InnerMessage::ViewHelper`.
Then in your view's layout, add `<%= message_frame %>`.
7. in routes, add `mount InnerMessage::Engine => "/inner_message"`
8. in development environment, add
```
  config.preload_frameworks = true
  config.allow_concurrency = true
```
to your config/environments/development.rb
9. after user signed in, you should assign session[:current_user] to signed user's id, inner_message use this to bind user.
10. in your app, user has ability to send and get messages.

## Example
```ruby
user = User.first
user.send_message({to_id: User.last.id, content: 'Wooha, I love ruby!'})
another_user = User.last
another_user.get_messages
```
