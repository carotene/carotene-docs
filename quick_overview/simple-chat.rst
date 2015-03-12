.. _scoreboard-simplechat-label:

Building a Simple Chat
======================

We will start creating the simplest chat application. In only a few lines of JavaScript we will have a publish/subscribe channel where users can publish their messages and subscribe to what others are saying in real-time.

First things first, let's make a HTML layout where we can see our progress. The component we are writing in this step looks like this:

.. image:: images/step1.png

You can download this HTML layout `here <http://carotene-project.com/livescoreboard/layout.html>`_ , the css `here <http://carotene-project.com/livescoreboard/scoreboard.css>`_ and carotene.js, the JavaScript Carotene library `here <https://github.com/carotene/carotene-js>`_.

Apart from some HTML boilerplate, the layout contains this piece of code:

.. code-block:: html

        <div class="row">
            <div class="col-md-5" id="scoreboard">
                <div id="scoreboard-messages">
                </div>
                <div class="input-group" id="publish-scoreboard-msg">
                    <input type="text" class="form-control" placeholder="New message">
                    <span class="input-group-addon" id="publish-general-chat">PUBLISH</span>
                </div>
            </div>
            <div class="col-md-3" id="general-chat">
                <div id="general-chatbox">
                </div>
                <div class="input-group" id="publish-chat-msg">
                    <input type="text" class="form-control" placeholder="New message" id="general-chat-input">
                    <span class="input-group-addon" id="publish-general-chat">PUBLISH</span>
                </div>
            </div>
        </div>

This defines two areas. The bigger one, on the left, will be used to display the comments of the administrator. The smaller one will host a general chat for supporters of both teams, where everyone can publish. In this step we will implement the general chat.

Now we are ready to bring dynamic elements to the application, communicating with Carotene from JavaScript in the client.

In the rest of the tuturial we will assume that you have a Carotene node running and listening to port ``8081``. If you have not installed Carotene yet, this is a good moment. Check out the :ref:`manual-installation-label` page of the manual.

Now let's add two features:

* When a user clicks the "Send" button, we will publish the entered text to the channel ``chat``.
* We will subscribe to the ``chat`` channel and set up a callback that will be called when a message is received, so we can update the list of messages received.

Place this code at the end of your HTML page (or in a separate file, if you prefer).

.. code-block:: javascript

    <script>
    $( document ).ready(function(){

        // Initialize connection with Carotene
        Carotene.init({
            caroteneUrl: 'ws://localhost:8081/websocket'
        });

        // Subscribe to a channel.
        // When a message is received, append it to the chat box.
        Carotene.subscribe({channel: 'chat',
            onMessage: function(message) {
                $('#general-chatbox').append('<div class="chatMessage">'+message.message+'</div>');
                var chatbox = $('#general-chatbox');
                chatbox.scrollTop(chatbox.prop("scrollHeight"));
            }
        });
    
        // Publish message to 'chat' channel
        var publishChatMsg = function() {
           Carotene.publish({
               channel: 'chat', 
               message: $('#general-chat-input').val()
           });
           $('#general-chat-input').val('');
        };
    
        // Register jQuery event to clicks to the Send button
        $(document).on('click', '#publish-general-chat', function() {
            publishChatMsg();
        });
    
        // Register jQuery event to publish when the 'enter' key is pressed
        $('#general-chat-input').keypress(function (e) {
            if (e.which == 13) {
                publishChatMsg();
            }
        });
    
    });
    </script>

Reload your page and try to write. This is it, a chat running in real-time. Go and open another tab or open the page in a different device. If you write in one window, you will see the messages updating automatically.

There are three calls that are worth of discussion:

.. code-block:: javascript

        // Initialize connection with Carotene
        Carotene.init({
            caroteneUrl: 'ws://localhost:8081/websocket'
        });

This call starts a connection to our Carotene server. After this moment, we have a bidirectional communication channel with the server where we can send and receive messages.

.. code-block:: javascript

        // Subscribe to a channel.
        // When a message is received, append it to the chat box.
        Carotene.subscribe({channel: 'chat',
            onMessage: function(message) {
                $('#general-chatbox').append('<div class="chatMessage">'+message.message+'</div>');
                var chatbox = $('#general-chatbox');
                chatbox.scrollTop(chatbox.prop("scrollHeight"));
            }
        });

With this call, we declare that we want to do some action when a message is received in the channel ``chat``. We subscribe to the channel and bind a callback to this event. In our case, it will create an HTML element with the text of the message.

 
.. code-block:: javascript

        // Publish message to 'chat' channel
        var publishChatMsg = function() {
           Carotene.publish({
               channel: 'chat', 
               message: $('#general-chat-input').val()
           });
           $('#general-chat-input').val('');
        };

We will call the ``publishChatMsg`` function to publish a message to the ``chat`` channel.

With this, we have a simple chat room. In the next chapter we will see how to authenticate users against our backend, where we have information about the users of our site.

Check out the next step of the tutorial: :ref:`scoreboard-authentication-label`
