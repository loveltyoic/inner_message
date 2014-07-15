class messageViewModel 
  constructor: ->
    self = this
    self.messages = ko.observableArray([])
    self.unread = ko.observable(0)
    self.showingMessageBox = ko.observable(false)
    @init = ->
      faye = new Faye.Client("http://127.0.0.1:8080/faye")
      faye.subscribe "/#{window.APP.current_user_token}", (json) ->
        self.messages.push json
        self.unread(self.unread()+1)

    @toggleMessageBox = ->
      self.showingMessageBox(!self.showingMessageBox())

    @get_unread = -> 
      
    @init()


$(document).ready ->

  ko.applyBindings(new messageViewModel())    

  
