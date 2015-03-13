.. _scoreboard-serverapi-label:

Publishing and Subscribing from the backend
===========================================

In this step we will see how to publish messages and subscribe to channels from the backend.

This has many use cases. You may want to notify a user that she has received a message, or you may want to broadcast a message to all your visitors to inform them that an offer is about to expire. Also, you may want to listen to events that are happening in the client side, like logging a conversation or holding a history of the changes made in a collaborative application. Many of the use cases of this feature fall into the realm of data synchronization, which is a quite convoluted topic and we cannot cover it in this tutorial.

But enough talking, let's see how to publish and subscribe from the backend.

Publishing to Carotene is easy, you just have to issue a POST request to the API. You can try to send a message to the scoreboard with CURL from your terminal:

.. code-block:: bash

    curl --data "message=\"hi\"" http://localhost:8081/api/channels/scoreboard/messages

That is it. A POST request with a parameter ``message``. The content of ``message`` should be encoded in JSON. If it is not, Carotene will do try to encode it. Note that although in these examples we are just sending strings around, you could publish more complex structures.

In a real application, your backend will be doing these requests, instead of you doing them manually. Imagine that your admin has a separate web view where she enters the messages. You may want to do things with them, like store them in the database, and then publish them to Carotene. Or you can have messages that are scheduled to be sent at some times. This feature allows you to do so.

As you can see, we don't need to authenticate ourselves when talking to the API REST. Messages that arrive to it will be assumed to come from the backend. It is a very good idea to **restrict the access to the API** to an IP. Learn how to do it in the manual chapter :ref:`manual-restrict-api-access-label`.

Check out the next step of the tutorial: :ref:`scoreboard-authorization-label`

Now, in order to subscribe to channels, we need to change the configuration. We have to tell Carotene a list of the channels we want to subscribe to, and where to POST the messages that are received. Let's do it.

.. code-block:: erlang

    [{carotene, [
        % ... Other configuration options
        , {subscribe_url, "http://mybackend.com/carotene-consume"}
        , {subscribed_channels, ["chat"]}
    ]}

Once you have changed the configuration, restart Carotene to reload it::

    $ _rel/carotene/bin/carotene stop
    $ _rel/carotene/bin/carotene start

Once subscribed, all messages published into the ``chat`` channel will be POSTed into the url provided. We could use this feature in this application to detect people that get very annoying in the comments of sport events. Or to detect questions directed to the admin who is commenting the game. Or to make a raffle. But since this is backend-specific, we will let you come up with the application for this. Let's instead make something simple, like logging all the messages that arrive to the ``chat`` channel:

.. code-block:: php

    /**
     * @Route("/carotene-consume")
     */
    public function receiveRealtimeMessageAction(Request $request)
    {
        $message = json_decode($request->request->get('message'), true);
        $channel = $request->request->get('channel');
        $logger = $this->get('logger');
        $logger->info($message['user_id']." said ".$message['message']);
        $response = new Response("");
        return $response;
    }

As we can see, Carotene sends a POST request with two parameters: ``channel`` (the channel where this message was published) and ``message`` (the actual content of the message, encoded en JSON).

With this, we have covered how to publish and subscribe from our backend.

We are always looking for ways to improve the documentation. If you have problems or suggestions, open a `pull request <https://github.com/carotene/carotene-docs>`_ or send us an email at nacho@limenius.com.
