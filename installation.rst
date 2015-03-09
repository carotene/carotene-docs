Installation
============

Get dependencies
~~~~~~~~~~~~~~~~

Carotene is an Erlang application. To install Carotene you need a recent version of **Erlang** installed. See instructions `here <http://erlangcentral.org/downloads/>`.

To build Carotene you will also need **rebar**, a package manager (among other things) for Erlang:

.. code-block:: bash

    $ git clone git://github.com/rebar/rebar.git
    $ cd rebar
    $ ./bootstrap

This will generate a ``rebar`` command. Place it in a directory in your ``$PATH``, such as ``/usr/local/bin/``::

    $ sudo mv rebar /usr/local/bin/

Build Carotene
~~~~~~~~~~~~~~

Then, get Carotene::

    $ git clone https://github.com/carotene/carotene.git

Compiling
~~~~~~~~~

Compile it by running:::

    $ cd carotene
    $ make}

After this step, if things go as expected, you should have a ``_rel`` directory, where a release of carotene has been built.

Try to run it by typing:::

    $ _rel/carotene/bin/carotene console

You should see something like:::

    Starting Carotene node carotene@localhost
    HTTP server listening to port 8081
    Node started carotene@localhost
    Nodes in cluster [carotene@localhost]
    Eshell V6.2  (abort with ^G)

This is an Erlang console. You can use it for several purposes, but for now, just exit by typing ``q().``

After this check, you can just run Carotene in the background:::

    $ _rel/carotene/bin/carotene start

And that is it. You have a Carotene server running and accepting connections.

If you ever want to stop carotene use:::

    $ _rel/carotene/bin/carotene stop

Configuration
~~~~~~~~~~~~~

On ``_rel/carotene/releases/VERSION/sys.config`` you will find the config file. By default, it is very minimal, specifying only the port where carotene runs. You will see more configuration options in other chapters of this guide, for presence activation, authorization, configuration, SSL, running Carotene in a cluster and more, but at this point you have a working Carotene server managing connections and PubSub channels. You can also jump to an explanation of all the configuration options in the :ref:`manual-configuration_options` chapter.
