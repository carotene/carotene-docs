#lang pollen

◊(require pollen/highlight)
◊(make-highlight-css)

◊chapter{Back Messaging}

Carotene can be configured to republish every message received to a ◊b{RabbitMQ} queue or a ◊b{Redis PubSub} channel.

This is useful if you want to connect other services to Carotene, for instance for analysis and monitorization of activity.

◊h3{Redis}
To configure Redis as back broker, use the following configuration option:

◊highlight['erlang]{
[{carotene, [
    % ... Other configuration options
    {broker, redis}
    ]},
}]}

And Carotene will republish messages to Redis channels with the same names as the Carotene channel.

◊h3{RabbitMQ}
To configure RabbitMQ as back broker, use the following configuration option:

◊highlight['erlang]{
[{carotene, [
    % ... Other configuration options
    {broker, rabbitmq}
    ]},
}]}

Carotene will create a fanout exchange for each channel where it receives messages.
