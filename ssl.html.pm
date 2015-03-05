#lang pollen

◊(require pollen/highlight)
◊(make-highlight-css)

◊chapter{SSL Configuration}

SSL is highly recomended for security reasons, but also to have a higher chance of successful websocket connection when the user is behind a restrictive proxy. To configure SSL you have to add the following configuration rules:

◊highlight['erlang]{
[{carotene, [
    % ... Other configuration options
    {ssl, [
        {cacertfile, "/etc/my-ca.crt"},
        {certfile, "/etc/server.crt"},
        {keyfile, "/etc/server.key"}
        ]}
}]}

With the location of your corresponding ◊code{cacert}, ◊code{cert} and ◊code{key} files.

Once you have configured Carotene with SSL support, don't forget to access your carotene server with ◊code{wss://} instead of ◊code{ws://} in the client side code:

◊highlight['javascript]{
Carotene.init({
    caroteneUrl: 'wss://mycaroteneserver.com/websocket'
});
}

And also don't forget that the api will be now accessible via ◊code{https://} instead of ◊code{http://}.

