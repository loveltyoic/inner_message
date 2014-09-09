class adminViewModel
  constructor: ->
    self = this
    self.showingChannel = ko.observable()
    self.broadcasts = ko.observable([])
    self.channels = ko.observableArray([])

    self.init = ->
      $.getJSON '/inner_message/channels', (channels)->
        for channel in channels
          channel['broadcasts'] = ko.observableArray([])
          self.channels.push channel
          self.getBroadcasts(channel)

    self.createChannel = (d, e)->
      name = $(e.currentTarget).siblings('input').val()
      $.post '/inner_message/channels', { name: name}, (channel)->
        channel['broadcasts'] = ko.observableArray([])
        self.channels.push channel

    self.createBroadcast = (channel, e)->
      title = $(e.currentTarget).siblings('input')
      content = $(e.currentTarget).siblings('textarea')
      $.post '/inner_message/broadcasts', broadcast: { title: title.val(), content: content.val(), channel_id: channel.id }, (bc)->
        self.pushBroadcasts bc
        title.val('')
        content.val('')

    self.pushBroadcasts = (bc)->
      targetChannel = channel for channel in self.channels() when channel.id == bc.channel_id
      targetChannel.broadcasts ||= ko.observableArray([])
      targetChannel.broadcasts.push bc

    self.getBroadcasts = (channel)->
      $.getJSON "/inner_message/channels/#{channel.id}/broadcasts", (broadcasts)->
        self.pushBroadcasts bc for bc in broadcasts

    self.showChannel = (channel)->
      self.showingChannel(channel.id)


    self.init()

$(document).ready ->
  ko.applyBindings(new adminViewModel())