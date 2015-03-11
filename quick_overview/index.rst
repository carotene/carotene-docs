Building a Live Scoreboard with Carotene
========================================

To get started adding real-time with Carotene, we will start with a tutorial. In this practical example we will build a live scoreboard for sport events in 6 steps.

It will have an area where only administrators of the page can wrie updates of the game and everyone receives the messages as soon as they are published, and also a general chat where supporters of the teams can comment and read others messages.

In this tutorial you will learn:

* How to build a PubSub channel where everyone can publish and subscribe.
* How to authenticate users to identify who publishes each message.
* How to know who is participating in the chat, retrieving presence information.
* How to create PubSub channels where only some users can publish.
* How to subscribe our backend to a channel.
* How to scale into a clustered Carotene environment (for very popular games).
* How to republish messages into Redis of published messages to gather analytics.

Let's go!

.. toctree::
   :maxdepth: 2

   simple-chat
   authentication
   presence
   authorization
   serverapi
