#lang pollen

◊(require pollen/highlight)
◊(make-highlight-css)

◊chapter{Presence}

Presence is the ability of knowing who is subscribed to a channel in a given moment.

You can activate presence with the following configuration option:

◊highlight['erlang]{
[{carotene, [
    % ... Other configuration options
    {presence, true}
}]}

If you don't need presence and you have a high traffic, consider not activating it. Internally, in multi-server environments, it will ask for presence in every node of the cluster, and it may be a more costly operation than simple publishing or subscribing to channels.

◊section{Access from client}

To ask for a channel's presence, you can do the following call from the client JavaScript code:

◊highlight['javascript]{
Carotene.presence(channel);
}

Note that, for security reasons, the user asking for presence must be already subscribed to the channel.

◊section{Access from backend}

To get presence information from your backend, simply perform a GET request to ◊code{/api/channels/[mychannel]/presence}, where ◊code{[mychannel]} is the channel you are asking information about (wihouth the square brackets). You will receive the list of user ids subscribed to the channel.
