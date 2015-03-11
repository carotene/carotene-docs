.. _scoreboard-serverapi-label:

Publishing and Subscribing from the backend
===========================================

In this step we will see how to publish messages and subscribe to channels from the backend.

This has many use cases. You may want to notify a user she has received a message, or you may want to broadcast a message to all your visitors to inform them that a offer is about to expire.

Publishing to Carotene is easy, you just have to issue a POST request to the api. You can try to send a message to the scoreboard with CURL:

.. code-block:: bash

    curl --data "message=\"hi\"" http://localhost:8081/api/channels/scoreboard/messages

That is it. A POST request with a parameter ``message``. The content of ``message`` should be encoded in JSON. If it is not, Carotene will do try to encode it. Note that although in these examples we are just sending strings around, you could publish more complex structures.

To subscribe, we need to change the configuration. We have to tell Carotene a list of the channels we want to subscribe to and where to POST the messages that are received. Let's do it.

.. code-block:: erlang

    [{carotene, [
        % ... Other configuration options
    , {publish_authorization, [
        {level, ask},
        {authorization_url, "http://mybackend.com/authorize-publish-carotene/"}
    ]}

