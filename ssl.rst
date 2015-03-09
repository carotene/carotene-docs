.. _manual-ssl-label:

Configuring SSL
===============

SSL is **highly recomended** for security reasons, but also to have a higher chance of successful websocket connection when the user is behind a restrictive proxy. To configure SSL you have to add the following configuration rules:

.. code-block:: erlang

    [{carotene, [
        % ... Other configuration options
        {ssl, [
            {cacertfile, "/etc/my-ca.crt"},
            {certfile, "/etc/server.crt"},
            {keyfile, "/etc/server.key"}
            ]}
    }]}

With the location of your corresponding ``cacert``, ``cert`` and ``key`` files.

Once you have configured Carotene with SSL support, don't forget to access your carotene server with ``wss://`` instead of ``ws://`` in the client side code:

.. code-block:: javasscript
    Carotene.init({
        caroteneUrl: 'wss://mycaroteneserver.com/websocket'
    });

And also don't forget that the api will be now accessible via ``https://`` instead of ``http://``.

