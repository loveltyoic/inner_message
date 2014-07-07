class messageViewModel 
  constructor: ->
    self = this
    self.messages = ko.observableArray([])
    self.unread = ko.observable(0)
    self.showingMessageBox = ko.observable(false)
    @listen = ->
      source = new EventSource('/inner_message/messages')
      source.onmessage = (event)->
        message = JSON.parse event.data
        self.messages.push message
        self.unread(self.unread()+1)

      source.addEventListener 'heartbeat', (e)->
        console.log e.data

    @toggleMessageBox = ->
      self.showingMessageBox(!self.showingMessageBox())

    @get_unread = -> 
      

    @listen()


$(document).ready ->

  ko.applyBindings(new messageViewModel())    

  
