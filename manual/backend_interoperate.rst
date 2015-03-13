Interoperating with a backend via HTTP
======================================

Subscribing to a channel
~~~~~~~~~~~~~~~~~~~~~~~~

Your backend can receive messages published into channels by specifying a URL where the messages will be published with ``POST`` requests, and which channels do you want to subscribe to:

.. code-block:: erlang

    [{carotene, [
        % ... Other configuration options
        {subscribe_url, "http://mybackend.com/carotene-consume"},
        {subscribed_channels, ["general", "room1"]}
    }]}

``subscribe_url`` will be the URL where the messages will be published. 

``subscribed_channels`` is an specification of the names of the channels you want to subscribe your backend to.

The requests received in your app will have the form of a ``POST`` requests with two parameters:

* ``message``: the message that has been published, encoded in JSON.
* ``channel``: the channel where it has ben been published.

Api REST
~~~~~~~~

Carotene provides a RESTful API to retrieve information about subscribed channels the backend is subscribed to, presence in channels and publishing messages.

Publishing to a channel
~~~~~~~~~~~~~~~~~~~~~~~

If you perform a ``POST`` query to ``http(s)://mycaroteneserver/api/channels/mychannel/messages`` with the parameter ``message``, you will publish that message into the channel.

Retrieving a list to subscribed channels
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

By performing a ``GET`` request to ``http(s)://mycaroteneserver/api/channels`` you can retrieve a list of the channels the server is subscribed to.

The list will be equivalent to what is specified in the configuration. So, if you have in your configuration an option like

.. code-block:: erlang

    [{carotene, [
        % ... Other configuration options
        {subscribed_channels, ["general", "room1"]}
    }]}

and if you access to ``http(s)://mycaroteneserver/api/channels``, you will retrieve a list of the channels that have been created and are in the list.


Retrieving presence information for a channel
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Performing a ``GET`` request to ``http(s)://mycaroteneserver/api/channels/mychannel/presence`` you can retrieve a list of the users subscribed to the channel ``mychannel`` in all the nodes.

