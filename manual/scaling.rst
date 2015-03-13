.. _manual-scaling-label:

Scaling Carotene
================

You can have as many Carotene nodes as you need, joining them in a cluster. Nodes in a cluster will republish the messages they receive to the rest of clusters. Also, when they receive a request for the :ref:`manual-presence-label` in a channel, they will communicate with the other nodes to fullfill the petition.

Note that Carotene is designed for real time applications, where usually messages lose value quickly with time. If there is a partition --some nodes of the cluster get disconnected from the rest of the cluster-- messages received in a subcluster will not be sent to the other nodes and thus will be lost. In many real time applications this is acceptable, because it makes no sense to store the messages to be sent later, when the cluster is rejoined. Take this into consideration if you want to ensure that absolutely all the messages will be received by all the nodes when they recover from the partition.

Note that if you simply want to publish messages from your backend to the clients and subscribe to messages published by the clients, but you do not need clients to be able to receive messages from other clients, you don't even need a cluster. You can simply connect your backend to all your isolated Carotene nodes and receive every message from every node, and publish your messages to every Carotene node.

You can add nodes to the cluster dynamically, without restarting the whole cluster. Also, when a node crashes, it will rejoin the cluster automatically when is back to life.

Setting up a cluster
~~~~~~~~~~~~~~~~~~~~

Erlang cookie
^^^^^^^^^^^^^

Erlang nodes that want to connect with other nodes must share the same cookie. An Erlang cookie is an alphanumeric string. You can write whatever string you want.

The cookie is located in ``_rel/carotene/releases/VERSION/vm.args``. By default is ``carotene``. You should change it.

Node configuration
^^^^^^^^^^^^^^^^^^

Every carotene node must have a different node name. You can set the environment variable in the file ``_rel/carotene/releases/VERSION/vm.args`` of your Carotene installation (``VERSION`` is the version you are running). You can change the node name changing the option:
``-sname carotene@localhost`` to a nodename in a hostname that the other nodes know.

If you prefer to use long names for the nodes, such as ``carotene@myfulldomain.com``, instead of ``-sname carotene@domain`` use ``-name carotene@domain.com`` (note the difference ``sname``/``name``).

Note that for development you can have several nodes in the same machine named for instance ``carotene1@localhost``, ``betacarotene@localhost``...

To define the nodes your node will try to join on start up, use the following configuration option:

.. code-block:: erlang

    [{carotene, [
        % ... Other configuration options
        {nodes_in_cluster, ['carotene@carotene1', 'carotene@carotene2']},
        ]},
    }]}

For debugging problems, start carotene with:

.. code-block:: bash

    $ _rel/carotene/bin/carotene console

On start up, each node will display a message with the nodes that he connected to (including itself).
