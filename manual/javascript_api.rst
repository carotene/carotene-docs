.. _manual-jsapi-label:

JavaScript API
==============



You can find ``carotene.js`` from `its GitHub repository <https://github.com/carotene/carotene-js/>`_.

Add it to your HTML page:

.. code-block:: html

    <script type="text/javascript" src="js/carotene.js"></script>

To initialize Carotene, use this code:

.. code-block:: javascript

    Carotene.init({
        caroteneUrl: 'ws://my-carotene-server.com/websocket'
    });

Change ``ws://`` per ``wss://`` if you are using SSL. See the :ref:`manual-ssl-label` chapter for more information about how to configure SSL.


Publish
~~~~~~~

To publish to a channel, use the following call:

.. code-block:: javascript

    Carotene.publish({channel: "mychannel", message: "hello world!"});


Subscribe
~~~~~~~~~

To subscribe to a channel, you have to provide **the name of the channel** and a **callback function** that will be executed when a message is received:

.. code-block:: javascript

    Carotene.subscribe({channel: "mychannel",
                        onMessage: function(message) {
                                       console.log(message);
                                   }
                       });


Messages received are JavaScript objects. If it is a message sent by another user, it will have these fields:

* ``message``: the content of the message
* ``user_id``: the user identifier of the publisher or ``anonymous`` if the user has not authenticated itself.
* ``user_data``: the user data provided by the server in the :ref:`manual-security-authentication` section of the :ref:`manual-security-label` chapter.

If the message comes from your backend, it will not contain fields that identify the user, but instead it will have the field ``fromserver``, with value ``true``.

Authentication
~~~~~~~~~~~~~~

To authenticate the client to Carotene, you have the following method available:

.. code-block:: javascript

    Carotene.authenticate({ userId: "some_user_identifier",
                            token: "token_for_this_user"
    });

``user_id`` and ``token`` are two pieces of information known by your backend that can be used to authenticate a user. The format of both of them is totally up to you, since it is your backend who checks if they are valid or not.
 
See the :ref:`manual-security-label` chapter to learn how to enable authentication and how tokens work in Carotene.

Presence
~~~~~~~~

To ask for the identified users subscribed in a channel, you need to do two things:

Provide a callback to be executed when you receive the presence information from server:

.. code-block:: javascript

    Carotene.setOnPresence(function(presenceData) {
        console.log(presenceData);
    });

Ask for the presence information of the channel:

.. code-block:: javascript

    Carotene.presence({channel: "mychannel"});

Carotene will processes the request, and call your callback with the information.

Your ``OnPresence`` callback will receive an object with two fields: ``channel`` (then name of the channel), and ``subscribers`` (the list of users subscribed to the channel).

Also, be sure you have presence enabled in your configuration. Check the :ref:`manual-presence-label` chapter to learn how to do it.

Note that, for security reasons, the client asking for presence must be subscribed himself to the channel, or the request will fail.


Informative messages
~~~~~~~~~~~~~~~~~~~~

Carotene sends clients a number of informative messages informing about the result of certain actions, such as the result of the authentication, error messages ir the user is not authorized to publish or subscribe to a particular message or a success reply if the user after correct authentication.

In most fo cases, you can ignore these messages but, specially during development they may be useful to understand what is happening. You can define a callback to log them to the console, for instance:

.. code-block:: javascript

    Carotene.setOnInfo(function(infoData) {
        console.log(infoData);
    });

The parameter passed to your callback, in this case ``infoData`` is a string with an informative message.