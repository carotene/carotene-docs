.. _manual-installation-label:

Installation
============

Debian / Ubuntu
---------------

To install Carotene on Debian / Ubuntu, download our ``.deb`` package and install it:

`carotene_0.2.2-1_i386.deb <http://carotene-project.com/releases/carotene_0.2.2-1_i386.deb>`_

.. code-block:: bash

    $ dpkg -i carotene_0.2.2-1_i386.deb

To start carotene, run ``sudo service carotene start``, if it is not running right after the installation.

Your configuration files will live in ``/etc/carotene/``, being ``carotene.config`` the main configuration file, and ``vm.args`` the arguments for the Erlang Virtual Machine. If you don't know what this means, don't worry, you probably won't need to change ``vm.args`` unless you are running Carotene in cluster mode.

In the following sections of this manual you will see what are the available options for ``carotene.config``. Note that Carotene uses by default the port 8081, so if you want to use a different port, change it in ``carotene.config``.

You can also jump to an explanation of all the configuration options in the :ref:`manual-configuration-options-label` chapter.

Mac OS X
--------

To install Carotene on Mac OS X using ``homebrew``, just run:

.. code-block:: bash

    $ brew tap carotene/carotene
    $ brew install carotene

Your configuration files will live in ``/usr/local/etc/carotene/``, being ``carotene.config`` the main configuration file, and ``vm.args`` the arguments for the Erlang Virtual Machine. If you don't know what this means, don't worry, you probably won't need to change ``vm.args`` unless you are running Carotene in cluster mode.

In the following sections of this manual you will see what are the available options for ``carotene.config``. Note that Carotene uses by default the port 8081, so if you want to use a different port, change it in ``carotene.config``.

You can also jump to an explanation of all the configuration options in the :ref:`manual-configuration-options-label` chapter.

Compiling from source
---------------------

Get dependencies
~~~~~~~~~~~~~~~~

Carotene is an Erlang application. To install Carotene you need a recent version of **Erlang** installed. See instructions `here <http://erlangcentral.org/downloads/>`_.

To build Carotene you will also need **rebar**, a package manager (among other things) for Erlang:

.. code-block:: bash

    $ git clone git://github.com/rebar/rebar.git
    $ cd rebar
    $ ./bootstrap

This will generate a ``rebar`` command. Place it in a directory in your ``$PATH``, such as ``/usr/local/bin/``:

.. code-block:: bash

    $ sudo mv rebar /usr/local/bin/

Build Carotene
~~~~~~~~~~~~~~

Then, get Carotene:

.. code-block:: bash

    $ git clone https://github.com/carotene/carotene.git

Compiling
~~~~~~~~~

Compile it by running:

.. code-block:: bash

    $ cd carotene
    $ make

After this step, if things go as expected, you should have a ``_rel`` directory, where a release of carotene has been built.

Try to run it by typing:

.. code-block:: bash

    $ _rel/carotene/bin/carotene console

You should see something like:

.. code-block:: bash

    Starting Carotene node carotene@localhost
    HTTP server listening to port 8081
    Node started carotene@localhost
    Nodes in cluster [carotene@localhost]
    Eshell V6.2  (abort with ^G)

This is an Erlang console. You can use it for several purposes, but for now, just exit by typing ``q().``

After this check, you can just run Carotene in the background:

.. code-block:: bash

    $ _rel/carotene/bin/carotene start

And that is it. You have a Carotene server running and accepting connections.

If you ever want to stop carotene use:

.. code-block:: bash

    $ _rel/carotene/bin/carotene stop

Configuration
~~~~~~~~~~~~~

On ``_rel/carotene/releases/VERSION/sys.config`` you will find the config file. By default, it is very minimal, specifying only the port where carotene runs. You will see more configuration options in other chapters of this guide, for presence activation, authorization, configuration, SSL, running Carotene in a cluster and more, but at this point you have a working Carotene server managing connections and PubSub channels. You can also jump to an explanation of all the configuration options in the :ref:`manual-configuration-options-label` chapter.
