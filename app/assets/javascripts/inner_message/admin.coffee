class adminViewModel
  constructor: ->
    self = this
    self.showingChannel = ko.observable()
    self.broadcasts = ko.observable({})
    self.channels = ko.observableArray([])

    self.init = ->
      $.getJSON '/inner_message/channels', (channels)->
        self.channels(channels)
      $.getJSON '/inner_message/admin/broadcasts', (broadcasts)->
        self.pushBroadCasts bc for bc in broadcasts

    self.createChannel = (d, e)->
      name = $(e.currentTarget).siblings('input').val()
      $.post '/inner_message/channels', { name: name}, (channel)->
        self.channels.push channel

    self.createBroadcast = (channel, e)->
      title = $(e.currentTarget).siblings('input').val()
      content = $(e.currentTarget).siblings('textarea').val()
      $.post '/inner_message/broadcasts', broadcast: { title: title, content: content, channel_id: channel.id }, (bc)->

    self.pushBroadCasts = (bc)->
      self.broadcasts()[bc.channel_id] ||= ko.observableArray([])
      self.broadcasts()[bc.channel_id].push bc

    self.showChannel = (channel)->
      self.showingChannel(channel.id)
      
    self.init()

$(document).ready ->
  ko.applyBindings(new adminViewModel())