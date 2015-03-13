.. _scoreboard-authorization-label:

Authorization
=============

In this step we will enable the scoreboard, where an admin of the site will update the score and comment the plays, so that all users receive the updates in real-time. To do so, we need a way to **authorize** only our admins.

In Carotene there are three levels of authorization. In the default mode, **anonymous**, everyone can access the channel. In **authenticated** mode only authenticated users can access the channel. In the third level, **ask**, Carotene will ask your backend if a user is authorized to access a channel. The logic of your application will decide it.

For this example, we will leave the subscription to the channel in *anonymous* level (we want to be possible for everyone to read messages), but we will change the level required for publication to *ask*.

To do so, we need to change the configuration of Carotene:

.. code-block:: erlang

    [{carotene, [
        % ... Other configuration options
    , {publish_authorization, [
        {level, ask},
        {authorization_url, "http://mybackend.com/carotene-authorize-publish"}
    ]}

The url is an endpoint that Carotene will use to ask your backend if the user is authorized or not, in a similar way as we did with authentication.

Once you have changed the configuration, restart Carotene to reload it::

    $ _rel/carotene/bin/carotene stop
    $ _rel/carotene/bin/carotene start

Now, when a user tries to publish to a channel for the first time, Carotene will issue a POST request to the url you have configured with two parameters:

* ``user_id``: user identifier.
* ``channel``: the channel the user is trying to access.

The implementation of your authorization code will depend on your needs, and also on the language you are using. For instance, in PHP/Symfony it could be something like this:

.. code-block:: php

    /**
     * @Route("/authorize-publish-carotene")
     */
    public function authorizeAction(Request $request)
    {
        $userId = $request->request->get('user_id');
        $channel = $request->request->get('channel');

        if ($channel != 'scoreboard') {
            $authorized = true;
        } else {
            // Your authentication code
            // $authorized = isAuthorized($userId, $channel);
            // (You can just set $authenticated = false;
            // or $authenticated = true; to continue the tutorial)
        }

        $result = json_encode(array(
            'authorized' => $authorized
        ));
        $response = new Response($result);
        $response->headers->set('Content-Type', 'application/json');
        return $response;
    }

Here we are restricting access to the ``scoreboard`` channel, but allowing access to everything else. We want our users to be able to publish to the chat.

Next, change the JavaScript code to enable the scoreboard:

.. code-block:: javascript

    Carotene.subscribe({channel: 'scoreboard',
        onMessage: function(message) {
            $('#scoreboard-messages').prepend('<div class="chatMessage">'+message.message+'</div>');
        }
    });

    var publishScoreboardMsg = function() {
       Carotene.publish({
           channel: 'scoreboard',
           message: $('#scoreboard-input').val()
       });
       $('#scoreboard-input').val('');
    };

    $(document).on('click', '#publish-scoreboard', function() {
        publishScoreboardMsg();
    });

    $('#scoreboard-input').keypress(function (e) {
        if (e.which == 13) {
            publishScoreboardMsg();
        }
    });

This is similar to what we did in the first step, :ref:`scoreboard-simplechat-label`: we subscribe the client to the new channel ``scoreboard`` and publish messages to this channel whenever the user hits the enter key or clicks the publish button.

Of course, in a real application you will want to have two separate versions, one for your admins with the publishing controls of the scoreboard, and another for the rest of users without them. But still you need to restrict who can publish to the server.

Now you are an expert of authorization in Carotene. In the next step we will add the configuration necessary to subscribe to channels and publish from your backend.

Check out the next step of the tutorial: :ref:`scoreboard-serverapi-label`

We are always looking for ways to improve the documentation. If you have problems or suggestions, open a `pull request <https://github.com/carotene/carotene-docs>`_ or send us an email at nacho@limenius.com.
