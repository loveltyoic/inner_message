class messageViewModel
  constructor: ->
    self = this
    self.conversations = ko.observableArray([])
    self.unread = ko.observable(0)
    self.showingMessageBox = ko.observable(false)
    self.showingConversation = ko.observable(false)

    self.markAsRead = (message, event) ->
      return if message.read
      $.post("/inner_message/messages/#{message.id}/read")
        .done (data) ->
          message.read = true
          $(event.currentTarget).removeClass('unread')
          self.unread(self.unread()-1)

    self.init = ->
      faye = new Faye.Client("#{window.APP.faye_server}")
      faye.subscribe "/#{window.APP.current_user_token}", (message) ->
        message['read'] = false
        self.getMessage(message)
        self.unread(self.unread()+1)
      self.get_unread()

    self.getMessage = (message)->
      index = -1
      index = i for c, i in self.conversations() when c.id == message.from_id

      if index >= 0
        self.conversations()[index].messages.push message
      else
        self.conversations.push {id: message.from_id, messages: ko.observableArray([message])}

    self.toggleMessageBox = ->
      container = $(window.parent.document.getElementById('iframe-container'))

      if(self.showingMessageBox())
        container.css('height', '30px')
      else
        container.css('height', '100%')

      self.showingMessageBox(!self.showingMessageBox())

    self.get_unread = ->
      $.getJSON('/inner_message/messages')
        .done (messages) ->
          self.getMessage msg for msg in messages
          self.unread(messages.length)

    self.reply = (message) ->
      textarea = $("#message-"+message.id+" .reply-box textarea")
      content = textarea.val()

      $.post("/inner_message/messages/#{message.id}/reply", {content: content})
        .done (data) ->
          self.resetReply(message)

    self.cancelReply = (message) ->
      self.resetReply(message)

    self.resetReply = (message) ->
      textarea = $("#message-"+message.id+" .reply-box textarea")
      textarea.val('')
      textarea.parent().fadeOut()

    self.showReply = (message) ->
      $("#message-"+message.id+" .reply-box").show()

    self.formatTime = (created_at) ->
      time = new Date(created_at)
      time.toLocaleTimeString()

    self.showConversation = (conversation)->
      self.showingConversation(conversation.id)

    self.hideConversation = ->
      self.showingConversation(false)

    self.init()


$(document).ready ->

  ko.applyBindings(new messageViewModel())


