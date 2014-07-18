InnerMessage.configure do |config|
  # Assign this to what the user class called in your app
  config.user_class = 'User'

  # After user signed in your app, you should store its id in session
  # like `session[:user_id] = user.id`
  # assign the session key's name.
  # As forward example, you should assign it as :user_id
  config.user_session_key = :user_id
end