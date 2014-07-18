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


- Config faye and thin for faye server
 - in /faye_server, edit thin.yml
 - in /config, edit faye_config.yml

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
