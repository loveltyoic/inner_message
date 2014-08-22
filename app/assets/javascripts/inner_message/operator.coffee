class OpViewModel
  constructor: ->
    self = this

    self.conversations = ko.observableArray([])

    self.initChat = ->
      faye = new Faye.Client("#{window.APP.faye_server}")
      faye.subscribe "/InnerMessage/Visitor/#{window.APP.operator_session_key}", (message) ->
        self.getMessage message
      faye.subscribe "/InnerMessage/Agent/#{window.APP.operator_session_key}", (message) ->
        self.getMessage message  

    self.getMessage = (message)->
      index = -1
      index = i for c, i in self.conversations() when c.id == message.from_id

      if index >= 0
        self.conversations()[index].messages.push message
      else
        self.conversations.push {id: message.from_id, messages: ko.observableArray([message])}

    self.formatTime = (time)->
      window.formatTime(time)

    self.replyInConversation = (reply)->
      index = i for c, i in self.conversations() when c.id == reply.to_id
      self.conversations()[index].messages.push reply

    self.reply = (c, e)->
      textarea = $(e.currentTarget).siblings('textarea')
      content = textarea.val()

      $.post("/inner_message/operators/#{window.APP.operator_id}/reply", {content: content, operator_id: window.APP.operatorId, visitor_id: c.id})
        .done (msg) ->
          textarea.val('')
          self.replyInConversation msg

    self.initChat()

$(document).ready ->
  ko.applyBindings(new OpViewModel())    