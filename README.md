# InnerMessage

An inner message system for rails app.

## Installation

Add this line to your application's Gemfile:

    gem 'inner_message'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install inner_message

## Configuration
1. Generate config file

  rails g inner_message:config

2. Generate faye config files

  rails g inner_message:faye


3. Install migrations

  rake inner_message:install:migrations

4. Migrate

  rake db:migrate


5. Update config/initializer/inner_message.rb to fit your app.


6. Config faye and thin for faye server
 - in /faye_server, edit thin.yml
 - in /config, edit faye_config.yml

7. Start faye server

  in '/faye_server', run `thin start -C thin.yml`

8. use `<%= message_frame %>` to embed a message iframe in you page.

## Usage
```ruby
user.send_message({to_id: User.last.id, content: 'Wooha, I love ruby!'})
#get all messages
another_user.get_messages
#or get unread messages
another_user.get_messages.unread
```
