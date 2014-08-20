window.formatTime = (created_at)->
  time = new Date(created_at)
  time.toLocaleTimeString()
