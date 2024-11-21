import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomPage extends StatelessWidget {
  final String username; // Current user's username
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Firestore instance

  RoomPage({required this.username});

  final TextEditingController _messageController =
      TextEditingController(); // Controller for the message input field

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'), // App bar title for the chat room
        backgroundColor:
            Theme.of(context).colorScheme.primary, // Dynamic theme color
        centerTitle: true, // Center the app bar title
      ),
      body: Column(
        children: [
          // Chat messages list
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              // Stream of messages ordered by creation time
              stream: _firestore
                  .collection('rooms')
                  .doc(
                      'defaultRoom') // Static room ID; replace with dynamic ID if needed
                  .collection('messages')
                  .orderBy('createdAt',
                      descending: true) // Latest messages appear first
                  .snapshots(),
              builder: (context, snapshot) {
                // Show a loading indicator while waiting for data
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                // Show a placeholder if no messages exist
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No messages yet.'));
                }

                // Build a list of chat messages
                return ListView.builder(
                  reverse: true, // Display latest messages at the bottom
                  itemCount:
                      snapshot.data!.docs.length, // Total number of messages
                  itemBuilder: (context, index) {
                    var message =
                        snapshot.data!.docs[index]; // Single message document
                    bool isMe = message['username'] ==
                        username; // Check if the message is sent by the current user

                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Show an avatar for other users' messages on the left
                          if (!isMe) ...[
                            CircleAvatar(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer, // Avatar background color
                              child: Text(
                                message['username'][0]
                                    .toUpperCase(), // Display first letter of the username
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer, // Avatar text color
                                ),
                              ),
                            ),
                            SizedBox(
                                width: 8), // Space between avatar and message
                          ],
                          // Message bubble
                          Expanded(
                            child: Align(
                              alignment: isMe
                                  ? Alignment.centerRight
                                  : Alignment
                                      .centerLeft, // Align message based on sender
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 8.0),
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: isMe
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context)
                                          .colorScheme
                                          .primaryContainer, // Different background for sender and receiver
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                    bottomLeft: isMe
                                        ? Radius.circular(12)
                                        : Radius.zero, // Rounded corners
                                    bottomRight: isMe
                                        ? Radius.zero
                                        : Radius.circular(12),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Show username for received messages
                                    if (!isMe)
                                      Text(
                                        message['username'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer,
                                        ),
                                      ),
                                    if (!isMe)
                                      SizedBox(
                                          height:
                                              4), // Space between username and text
                                    // Message text
                                    Text(
                                      message['text'],
                                      style: TextStyle(
                                          color: isMe
                                              ? Colors.white
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .onPrimaryContainer),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Show an avatar for current user's messages on the right
                          if (isMe) ...[
                            SizedBox(
                                width: 8), // Space between message and avatar
                            CircleAvatar(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer, // Avatar background color
                              child: Text(
                                username[0]
                                    .toUpperCase(), // Display first letter of the username
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer, // Avatar text color
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // Message input field
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                // Text field for typing a message
                Expanded(
                  child: TextField(
                    controller:
                        _messageController, // Link controller to the text field
                    decoration: InputDecoration(
                      labelText: '     Type a message',
                      filled: true,
                      fillColor: Theme.of(context)
                          .colorScheme
                          .primaryContainer, // Background color
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none, // No border
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2.0), // Focused border style
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8), // Space between text field and send button
                // Send button
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    if (_messageController.text.trim().isNotEmpty) {
                      // Add message to Firestore
                      await _firestore
                          .collection('rooms')
                          .doc(
                              'defaultRoom') // Static room ID; replace with dynamic if needed
                          .collection('messages')
                          .add({
                        'username': username, // Sender's username
                        'text': _messageController.text.trim(), // Message text
                        'createdAt': FieldValue.serverTimestamp(), // Timestamp
                      });
                      _messageController
                          .clear(); // Clear the input field after sending
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
