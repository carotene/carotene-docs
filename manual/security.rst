.. _manual-security-label:

Security
========

This chapter is divided in three sections:

* **Authentication**: Identify users based on credentials.
* **Authorization**: Different levels of security, to restrict access to channels.
* **Restrict API access**: Rescrict the access to the API to a particular IP.


.. _manual-security-authentication-label:
Authentication
~~~~~~~~~~~~~~

Authenticating a user in Carotene serves two purposes. First, once authenticated, the verified user_id of the user will be attached to every message that the user publishes, making it possible for other users and the backend to know who is the origin of the messages. Second, once authenticated, this information will be used during authorization to subscribe or publish to private channels, as we will see in the authorization section.

To authenticate, from client side Javascript you call the function ``authenticate``:

.. code-block:: javascript

    Carotene.authenticate({
        userId: "myUserId",
        token: "somesecrettoken",
        });


Both ``userId`` and ``token`` are created by you. Provide the user identifier and generate a token in your backend that will identify that user. You can use the method you feel more comfortable with to generate the token, as your application will be the responsible for checking it later.

Once received an authentication request from the client, Carotene delegates the authentication to your backend. You have to provide an endpoint where Carotene will issue POST requests with the following parameters:

* ``user_id``: user identifier.
* ``token``: secret token.


Your application can use these credentials to decide if the ``token`` is valid for the ``user_id``.

Add the authentication endpoint to the configuration:

.. code-block:: erlang

    [{carotene, [
        % ... Other configuration options
        {authenticate_url, "http://mybackend.com/authenticate_carotene/"}
    }]}

If the authentication fails, your application must respond with a JSON encoded string with the form:

.. code-block:: javascript

    {"authenticated": false}

On the contrary, if it was succesful, your application must respond with a JSON encoded string of the form:

.. code-block:: javascript

    {"authenticated": true, "user_data": "some additional user info"}

The field ``user_data`` can be whatever JSON object you want. It will be attached to every message the user sends. It can be, for instance, the url of her avatar, or some metainformation that you want available in the client side. If you don't plan to use this feature, you can as well use a ``null`` value.

.. code-block:: erlang

    [{carotene, [
        % ... Other configuration options
        {authenticate_url, "http://mybackend.com/authenticate_carotene/"}
    }]}

Authorization
~~~~~~~~~~~~~

Carotene provides three levels of authorization:

anonymous
^^^^^^^^^
Everyone can publish or subscribe, authenticated or not.

For anonymous subscribers use:

.. code-block:: erlang

    [{carotene, [
        % ... Other configuration options
        {subscribe_authorization, [
            {level, anonymous}
        ]},
    }]}

authenticated
^^^^^^^^^^^^^

With this level, only authenticated users can publish or subscribe.

For subscribers use this configuration option:

.. code-block:: erlang

    [{carotene, [
        % ... Other configuration options
        {subscribe_authorization, [
            {level, authenticated}
        ]},
    }]}

For publishers use this configuration option:

.. code-block:: erlang

    [{carotene, [
        % ... Other configuration options
        {publish_authorization, [
            {level, authenticated}
        ]},
    }]}


ask
^^^

With this level, a request will be issued to the backend to the server in order to determine if the user can subscribe or publish to a particular channel.

This way, you can deal with different scenarios. From an application where every visitors will receive the new fresh content without needing to be authenticated, to complex requirements where only some users can publish or subscribe and only your backend has the logic to determine if the user has access she is asking for.

For subscribers use this configuration option:

.. code-block:: erlang

    [{carotene, [
        % ... Other configuration options
        {subscribe_authorization, [
            {level, ask},
            {authorization_url, "http://mybackend.com/carotene-authorize-subscribe"}
        ]},
    }]}

For publishers use this configuration option:

.. code-block:: erlang

    [{carotene, [
        % ... Other configuration options
        {publish_authorization, [
            {level, ask},
            {authorization_url, "http://mybackend.com/carotene-authorize-publish"}
        ]},
    }]}

Of course you should set ``authorization_url`` to the URL that will provide this service.

On the first publish or subscribe action, Carotene will issue a POST request to the url you have configured in ``authorization_url`` with the following parameters:

* ``user_id``: user identifier.
* ``channel``: the channel the user is trying to access.

If your backend decides that the user can access the channel, it has to respond with a JSON encoded string with the following form:

.. code-block:: javascript

    {"authorized": true}

On the contrary, if the user has no access to the channel, your application must respond with a JSON encoded string of the form:

.. code-block:: javascript

    {"authorized": false}

.. _manual-restrict-api-access-label:

Restrict API access
~~~~~~~~~~~~~~~~~~~

It is wise to restrict the access to your API so it cannot be accessed from the outside. You can do this with a firewall, but, if you only require to restrict access to a particular IP, then you can simply use this configuration:

.. code-block:: javascript

    [{carotene, [
        % ... Other configuration options
        {restrict_api_access_to, {127, 0, 0, 1}}
        ]},
    }]}

With this configuration the Carotene API will only be accessible from ``127.0.0.1``.
