#lang pollen

◊(require pollen/highlight)
◊(make-highlight-css)

◊chapter{Interoperating from a backend with HTTP}

◊section{Subscribing to a channel}

Your backend can receive messages published into channels by specifying a URL where the messages will be published with ◊code{POST} requests, and which channels do you want to subscribe to:

◊highlight['erlang]{
[{carotene, [
    % ... Other configuration options
    {subscribe_url, "http://mybackend.com/carotene_consume"},
    {subscribed_channels, ["general", "room1"]}
}]}

◊code{subscribe_url} will be the URL where the messages will be published. 

◊code{subscribed_channels} is an specification of the names of the channels you want to subscribe your backend to.

The requests received in your app will have the form of a ◊code{POST} requests with two parameters:

◊items{
◊item{◊code{message}: the message that has been published, encoded in JSON}
◊item{◊code{channel}: the channel where it has ben been published}
}

◊section{API REST}
Carotene provides a RESTful API to retrieve information about subscribed channels the backend is subscribed to, presence in channels and publishing messages.

◊section{Publishing to a channel}

If you perform a ◊code{POST} query to ◊code{http(s)://mycaroteneserver/api/channels/mychannel/messages} with the parameter ◊code{message} you will publish that message into the channel.

◊section{Retrieving a list of subscribed channels}

Performing a ◊code{GET} request to ◊code{http(s)://mycaroteneserver/api/channels} you can retrieve a list of the channels the server is subscribed to.

The list will be equivalent to what what is specified in the configuration. So, if you have in configuration an option like:

◊highlight['erlang]{
[{carotene, [
    % ... Other configuration options
    {subscribed_channels, ["general", "room1"]}
}]}

And if you access to ◊code{http(s)://mycaroteneserver/api/channels} you will retrieve a list of the channels that have been created and that are in the list.


◊section{Retrieving presence information for a channel}

Performing a ◊code{GET} request to ◊code{http(s)://mycaroteneserver/api/channels/mychannel/presence} you can retrieve a list of the users subscribed to the channel ◊code{mychannel} in all the nodes.

