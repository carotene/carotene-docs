#lang pollen

◊(require pollen/highlight)
◊(make-highlight-css)

◊chapter{JavaScript API}

You can find ◊code{carotene.js} from ◊link["https://github.com/carotene/carotene-js"]{this link}.

Add it to your HTML page:

◊highlight['html]{
<script type="text/javascript" src="js/carotene.js"></script>
}

To initialize Carotene, use this code:

◊highlight['javascript]{

Carotene.init({
    caroteneUrl: 'ws://my-carotene-server.com/websocket'
});
}

Change ◊code{ws://} per ◊code{wss://} if you are using ◊link["ssl.html"]{SSL}.

◊section{Subscribe}

To publish to a channel, use the following call:

◊highlight['javascript]{
Carotene.publish({channel: "mychannel", message: "hello world!"});
}

◊section{Subscribe}

◊highlight['javascript]{
Carotene.subscribe({channel: "mychannel",
                    onMessage: function(message) {
                                   console.log(message);
                               }
                   });
}

Messages received are JavaScript objects. If it is a message sent by another user, it will have these fields:

◊items{
◊item{◊code{message}}: the content of the message
◊item{◊code{user_id}}: the user identifier of the publisher or ◊code{anonymous} if the user has not authenticated itself.
◊item{◊code{user_data}}: the user data provided by the server on ◊link["security.html"]{authentication}.
}

If the message comes from your backend, it will not contain fields that identify the user, but instead it will have the field ◊code{fromserver}, with value ◊code{true}.

◊section{Authentication}
◊section{Presence}
