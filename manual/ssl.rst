.. _manual-ssl-label:

Configuring SSL
===============

SSL is **highly recomended** for security reasons, but also in order to have a higher chance of successful websocket connection when the user is behind a restrictive proxy. To configure SSL you have to add the following configuration rules:

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

Once you have configured Carotene with SSL support, don't forget to access your Carotene server with ``wss://`` instead of ``ws://`` in the client side code:

.. code-block:: javascript

    Carotene.init({
        caroteneUrl: 'wss://mycaroteneserver.com/stream'
    });

And also don't forget that the API will now be accessible via ``https://`` instead of ``http://``.

