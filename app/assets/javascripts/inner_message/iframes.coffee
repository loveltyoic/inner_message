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
      faye.subscribe "/InnerMessage/Agent/#{window.APP.current_user_token}", (message) ->
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
        container.css({'height': '30px', 'width': '30px', 'right': '50%'})
      else
        container.css({'height': '100%', 'width': '250px', 'right': '0'})

      self.showingMessageBox(!self.showingMessageBox())

    self.get_unread = ->
      $.getJSON('/inner_message/messages')
        .done (messages) ->
          self.getMessage msg for msg in messages
          self.unread(messages.length)

    self.reply = (conversation, e) ->
      textarea = $(e.currentTarget).siblings('textarea')
      content = textarea.val()
      initMsg = conversation.messages()[0]
      $.post("/inner_message/messages/#{initMsg.id}/reply", {content: content})
        .done (response) ->
          self.resetReply(textarea)
          self.replyInConversation(response.data)
          self.scrollMessageToBottom($(e.currentTarget).parent().siblings('.messages'))

    self.resetReply = (textarea) ->
      textarea.val('')

    self.formatTime = (created_at) ->
      window.formatTime(created_at)

    self.showConversation = (conversation)->
      self.showingConversation(conversation.id)

    self.hideConversation = ->
      self.showingConversation(false)

    self.replyInConversation = (reply)->
      index = i for c, i in self.conversations() when c.id == reply.to_id
      self.conversations()[index].messages.push reply

    self.scrollMessageToBottom = (dom) ->
      dom.animate({'scrollTop': dom[0].scrollHeight}, 0)

    self.init()


$(document).ready ->

  ko.applyBindings(new messageViewModel())


