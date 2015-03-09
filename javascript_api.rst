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

.. code-block:: javascript

    Carotene.subscribe({channel: "mychannel",
                        onMessage: function(message) {
                                       console.log(message);
                                   }
                       });
    }

Messages received are JavaScript objects. If it is a message sent by another user, it will have these fields:

* ``message``: the content of the message
* ``user_id``: the user identifier of the publisher or ``anonymous`` if the user has not authenticated itself.
* ``user_data``: the user data provided by the server in the :ref:`manual-security-authentication` section of the :ref:`manual-security-label` chapter.

If the message comes from your backend, it will not contain fields that identify the user, but instead it will have the field ``fromserver``, with value ``true``.

Authentication
~~~~~~~~~~~~~~

Presence
~~~~~~~~
