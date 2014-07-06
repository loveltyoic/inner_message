InnerMessage.configure do |config|
  # Assign this to what the user called in your app
  config.user_class = 'Player'

  # After user signed in your app, you should store its id in session
  # like `session[:user_id] = user.id`
  # config the session key's name, in this example, it is called :user_id
  config.user_session_key = :user_id
end