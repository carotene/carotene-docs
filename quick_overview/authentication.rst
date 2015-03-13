.. _scoreboard-authentication-label:

Authenticating Users
====================

In the first step, we saw how to create a simple chat in Carotene: :ref:`scoreboard-simplechat-label`

In this one, we will see how to identify users from our backend. Authenticating users is basic for many real-time applications. You may want to send messages from your backend to each user with notifications if, for instance, they have received a new message, or if they have received a new payment. Also, authentication is a prerrequisite for authorization, that we will cover in another step.

In many applications, we will have a backend that receives HTTP requests and sends appropiate responses written in our favorite technology. This backend can be written in any language and framework, and now we want to complement adding real-time capabilities for certain features or sections of our app, without having to rewrite everything or duplicate code.

We have in our backend a database of users and mechanisms to register and log users in. But, once logged in, we want to authenticate them in the real-time services.

Let's reuse your existent user providers. You will have to provide an endpoint where Carotene will issue ``POST`` requests with authentication petitions, so your backend can decide who is authenticated and who is not.

Edit the Carotene configuration to add a URL of your backend where you will implement this security check:

.. code-block:: erlang

    [{carotene, [
        % ... Other configuration options
        {authenticate_url, "http://mybackend.com/carotene-authenticate"}
    }]}

Your configuration file is located in ``_rel/carotene/releases/VERSION/sys.config``, relative to your Carotene installation. Substitute ``VERSION`` for your version of Carotene.

In the configuration file that is generated for you during installation you will have this option commented with a ``%`` sign. You can just remove the ``%`` to uncomment the option, enabling it.

Once you have changed the configuration, restart Carotene to reload the configuration::

    $ _rel/carotene/bin/carotene stop
    $ _rel/carotene/bin/carotene start


In the client code, add these lines of JavaScript, after initializing Carotene:

.. code-block:: javascript

    Carotene.authenticate({
        userId: "myUserId",
        token: "somesecrettoken",
    });

When you render the page in your backend, provide these two pieces of information, so that they are available in the rendered HTML code and can be placed in there. Every web technology has a different way of rendering pages, so just do it your way. The only important thing is that ``userId`` is something that identifies your user in your application and ``token`` is a secret string that can be used to check if the user is who he says to be.

There are many ways to generate these tokens. It can be from an Oauth Token to something you generate for the user. You can use, for instance, HMAC. See a good explanation about this topic in `this post <https://blog.jcoglan.com/2012/06/09/why-you-should-never-use-hash-functions-for-message-authentication/>`_.

Now it is time to write the server-side code that will check authentication requests. It depends on languages and frameworks, but for instance in PHP/Symfony would be something like this:

.. code-block:: php

    /**
     * @Route("/carotene-authenticate")
     */
    public function authenticateAction(Request $request)
    {
        $userId = $request->request->get('user_id');
        $token = $request->request->get('token');

        // Your authentication code
        // $authenticated = auth($userId, $token);
        // (You can just set $authenticated = true; to continue the tutorial)

        if ($authenticated) {
            $result = json_encode(array(
                    'authenticated' => true,
                    'user_data' => array('avatar' => 'http://lorempixel.com/40/40/sports?v='.rand())));
        } else {
            $result = json_encode(array(
                    'authenticated' => false,
                    ));
        }
        $response = new Response($result);
        $response->headers->set('Content-Type', 'application/json');
        return $response;
    }

The point here is that we will receive a POST request, with two parameters ``user_id`` and ``token``, that will be the same that we sent to Carotene from JavaScript.

Then, if we decide that the token is valid for the user, we return a JSON encoded string with ``authenticated`` set to ``true`` and ``user_data`` set to an array or structure that contains some additional data that you want to make available to the client side. In this case we will attach a random avatar.

It the token is invalid, then return ``authenticated`` with value ``false``.

If you just want to continue the tutorial without implementing a token authorization mechanism right now, just return ``authenticated: true`` in every case.

Now we will change the JavaScript code to attach the avatar of identified users when they publish a message.


.. code-block:: javascript

    Carotene.subscribe({channel: 'chat',
            onMessage: function(message) {
                if (message.userData == 'undefined') {
                    $('#general-chatbox').append('<div class="chatMessage">'+message.message+'</div>');
                } else {
                    $('#general-chatbox').append('<div class="chatMessage"><img src="'+message.userData.avatar+'">'+message.message+'</div>');
                }
                var chatbox = $('#general-chatbox');
                chatbox.scrollTop(chatbox.prop("scrollHeight"));
            }
        });

This is what we have built so far:

.. image:: images/after-step2.png

Remember that, if things go wrong, you can open a Websocket inspector in your browser. In Google Chrome, for instance, you have one in Developer Tools:

.. image:: images/debug-ws-chrome.png

In this case, we see that Carotene is sending us a frame of type ``info`` that tells us that the server is not returning a valid response. In this case try making POST requests to your authentication URL manually (or with CURL) with ``user_id`` and ``token`` as parameters to check if the response is valid.

You can also log these messages during development using this JavaScript line:

.. code-block:: javascript

    Carotene.setOnInfo(function(info) {
        console.log('DEBUG: '+ info.payload);
    });

Note that if you open this example in two windows, the avatars for each user may change between windows. This is because we are using ``http://lorempixel.com/40/40/sports`` that serves random images that change every time they are served. In a real application, where you have an avatar for every user, this won't happen, but it is quite out of the scope of this tutorial to go into the topic of avatar management.

In the next step we will add presence information to know the list of users that are subscribed in a particular moment.

Check out the next step of the tutorial: :ref:`scoreboard-presence-label`

We are always looking for ways to improve the documentation. If you have problems or suggestions, open a `pull request <https://github.com/carotene/carotene-docs>`_ or send us an email at nacho@limenius.com.
