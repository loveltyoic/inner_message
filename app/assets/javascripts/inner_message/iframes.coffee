class messageViewModel 
  constructor: ->
    self = this
    self.messages = ko.observableArray([])
    self.unread = ko.observable(0)
    self.showingMessageBox = ko.observable(false)

    @markAsRead = (message, event) ->
      return if message.read
      $.post("/inner_message/messages/#{message.id}/read")
        .done (data) ->
          message.read = true
          $(event.currentTarget).removeClass('unread')
          self.unread(self.unread()-1)

    @init = ->
      faye = new Faye.Client("#{window.APP.faye_server}")
      faye.subscribe "/#{window.APP.current_user_token}", (json) ->
        json['read'] = false
        self.messages.push json
        self.unread(self.unread()+1)
      @get_unread()

    @toggleMessageBox = ->
      self.showingMessageBox(!self.showingMessageBox())

    @get_unread = -> 
      $.getJSON('/inner_message/messages')
        .done (data) ->
          self.messages(data)
          self.unread(data.length)
      
    @reply = (message) ->
      content = $("#"+message.id).val()
      $.post("/inner_message/messages/#{message.id}/reply", {content: content})
        .done (data) ->
          console.log data

    @formatTime = (created_at) ->
      time = new Date(created_at)
      time.toLocaleTimeString()

    @init()


$(document).ready ->

  ko.applyBindings(new messageViewModel())    

  
