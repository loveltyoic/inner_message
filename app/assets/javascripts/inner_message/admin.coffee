class adminViewModel
  constructor: ->
    self = this
    self.showingPage = ko.observable('channel-list')
    self.broadcasts = ko.observable([])
    self.channels = ko.observableArray([])
    self.newChannelName = ko.observable('')
    self.systemChannel = ko.observable(true)

    self.init = ->
      $.getJSON '/inner_message/channels', (channels)->
        for channel in channels
          channel['broadcasts'] = ko.observableArray([])
          self.channels.push channel
          self.getBroadcasts(channel)

    self.newChannel = ->
      self.showingPage('channel-new')

    self.createChannel = (d, e)->
      name = self.newChannelName()
      $.post '/inner_message/channels', { name: name, system: self.systemChannel() }, (channel)->
        channel['broadcasts'] = ko.observableArray([])
        self.channels.push channel
        self.showingPage('channel-'+channel.id)
        self.newChannelName('')

    self.createBroadcast = (channel, e)->
      title = $('#br-title-'+channel.id)
      content = $('#br-content-'+channel.id)
      $.post '/inner_message/broadcasts', broadcast: { title: title.val(), content: content.val(), channel_id: channel.id }, (bc)->
        bc['read'] = 0
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
      self.showingPage('channel-'+channel.id)

    self.returnToChannelList = ->
      self.showingPage('channel-list')

    self.init()

$(document).ready ->
  ko.applyBindings(new adminViewModel())