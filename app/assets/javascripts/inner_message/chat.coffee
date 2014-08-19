class ChatViewModel
  constructor: ->
    self = this
    self.chatIsShowing = ko.observable(false)
    @toggleChat = ->
      self.chatIsShowing(!self.chatIsShowing())

$(document).ready ->
  ko.applyBindings(new ChatViewModel())