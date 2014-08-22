class ChatViewModel
  constructor: ->
    self = this
    self.chatIsShowing = ko.observable(false)
    self.historyMessages = ko.observableArray([])

    self.initChat = ->
      faye = new Faye.Client("#{window.APP.faye_server}")
      faye.subscribe "/InnerMessage/Operator/#{window.APP.visitor_session_key}", (message) ->
        self.historyMessages.push message
        
      self.historyMessages.push
        content: "This is #{window.APP.operatorId}.What can I do for you?"
        from_id: window.APP.operatorId
        id: 0
        created_at: new Date()

    self.toggleChat = ->
      container = $(window.parent.document.getElementById('iframe-chat'))

      if(self.chatIsShowing())
        container.css({'height': '55px', 'width': '210px'})
      else
        container.css({'height': '350px', 'width': '250px'})

      self.chatIsShowing(!self.chatIsShowing())

    self.resetText = ->
      $("#chat-message").val('')

    self.formatTime = (time)->
      window.formatTime(time)

    self.reply = ->
      textarea = $("#chat-message")
      content = textarea.val()

      $.post("/inner_message/chat", {content: content, operator_id: window.APP.operatorId})
        .done (msg) ->
          self.resetText()
          self.historyMessages.push msg

    self.initChat()

$(document).ready ->
  ko.applyBindings(new ChatViewModel())