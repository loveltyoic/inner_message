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
- Generate config file
```
    rails g inner_message:config
```  

- Generate faye config files
```
    rails g inner_message:faye
```

- Install migrations
```
    rake inner_message:install:migrations
```
- Migrate
```
    rake db:migrate
```

- Update config/initializer/inner_message.rb to fit your app.

- Edit config/inner_message_config.yml if necessary.


- Config faye and thin for faye server
 - Edit /faye_server/thin.yml

- To start faye server, cd to /faye_server
```
    thin start -C thin.yml
```

## Usage

### ViewHelper
In view page, use `<%= message_frame %>` to embed a message iframe.

### Send & Get
```ruby
user.send_message({to_id: User.last.id, content: 'Wooha, I love ruby!'})
#get all messages
another_user.get_messages
#or get unread messages
another_user.get_messages.unread
```
####Broadcast and Channel
```ruby
channel = InnerMessage::MessageChannel.create(name: 'test')
#send broadcast
channel.send_broadcast(title, content)
#user can subscribe to channel
user.subscribe_channel(channel.id)
#user can unsubscribe channel
user.unsubscribe_channel(channel.id)
#user get broadcasts from subscribed channel
user.get_broadcasts_by_channel_id(channel.id)
user.get_unread_broadcasts_by_channel_id(channel.id)



