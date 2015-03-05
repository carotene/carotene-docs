#lang pollen

◊(require pollen/highlight)
◊(make-highlight-css)

◊chapter{Scaling Carotene}

You can have as many Carotene nodes as you need, joining them in a cluster. Nodes in a cluster will republish the messages they receive to the rest of clusters. Also, when they receive a request for the presence in a channel, they will communicate with the other nodes to fullfill the petition.

Note that Carotene is designed for real time applications, where usually messages lose value quickly with time. If there is a partition --some nodes of the cluster get disconnected from the rest of the cluster-- messages received in a subcluster will not be sent to the other nodes and thus will be lost. In many real time applications this is acceptable, because it makes no sense to store the messages to be sent later, when the cluster is rejoined. Take this into consideration if you want to ensure that absolutely all the messages will be received by all the nodes when they recover from the partition.

Note that if you simply want to publish messages from your backend to the clients and subscribe to messages published by the clients, but you do not need clients to be able to receive messages from other clients, you don't even need a cluster. You can simply connect your backend to all your isolated Carotene nodes and receive every message from every node, and publish your messages to every Carotene node.

You can add nodes to the cluster dynamically, without restarting the whole cluster. Also, when a node crashes, it will rejoin the cluster automatically when is back to life.

◊section{Setting up a cluster}
◊h3{Erlang cookie}
Erlang nodes that want to connect with other nodes must share the same cookie. An Erlang cookie is an alphanumeric string. You can write whatever string you want.

On startup, Erlang will create one for you. You can simply start your first node and then copy the cookie to the other machines in your cluster.

On Unix systems, you can find your Erlang cookie in ◊code{$HOME/.erlang.cookie}.

◊h3{Node configuration}

Every carotene node must have a different node name. You can set the environment variable ◊code{CAROTENE_NODENAME} for this purpose. By default, it is set to ◊code{carotene@$HOSTNAME}. Note that the host name must be known to the other nodes. If you are running your server from Erlang runtime system ◊code{erl} you can also provide the name with the ◊code{-sname} option.

To define the nodes your node will try to join on start up, use the following configuration option:

◊highlight['erlang]{
[{carotene, [
    % ... Other configuration options
    {nodes_in_cluster, [carotene@carotene1, carotene@carotene2]},
    ]},
}]}

To check the health of your cluster you can run the command ◊code{./scripts/carotene_control.sh cluster_status -n carotene@carotene1}. With this call you can check the cluster status from the point of view of the node ◊code{carotene@carotene1}. It will return a list of the nodes, like:

◊pre{
[carotene@carotene1, carotene@carotene2]
}
