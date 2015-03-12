Building a Live Scoreboard with Carotene
========================================

To get started adding real-time with Carotene, we will follow a step-by-step tutorial that shows all Carontene's main features. In this practical example we will build a live scoreboard for sport events in a few steps.

It will have an area where only administrators of the page can write updates of the game and everyone receives messages as soon as they are published. It will include as well a general chat where supporters of the teams can rant and read others' opinions.

In this tutorial you will learn:

* How to build a PubSub channel where everyone can publish and subscribe.
* How to authenticate users in order to identify who publishes each message.
* How to know who is participating in the chat, retrieving presence information.
* How to create PubSub channels where only some users can publish.
* How to subscribe our backend to a channel and publish to it.

Let's go!

.. toctree::
   :maxdepth: 2

   simple-chat
   authentication
   presence
   authorization
   serverapi
