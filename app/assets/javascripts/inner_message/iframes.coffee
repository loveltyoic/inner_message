class messageViewModel 
  constructor: ->
    self = this
    self.messages = ko.observableArray([])
    self.unread = ko.observable(0)
    self.showingMessageBox = ko.observable(false)

    @markAsRead = (message) ->
      console.log message
      $.post("/inner_message/messages/#{message.id}/read")
        .done (data) ->
          self.unread(self.unread()-1)

    @init = ->
      faye = new Faye.Client("http://127.0.0.1:8080/faye")
      faye.subscribe "/#{window.APP.current_user_token}", (json) ->
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
      

    @init()


$(document).ready ->

  ko.applyBindings(new messageViewModel())    

  
