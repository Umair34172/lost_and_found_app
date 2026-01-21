/* import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String contactName;

  const ChatScreen({
    super.key,
    required this.contactName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Message> _messages = [
    Message(
      text: "I think those might be mine!",
      isSentByMe: true,
      time: "10:30 AM",
    ),
    Message(
      text: "Where did you find them?",
      isSentByMe: true,
      time: "10:31 AM",
    ),
    Message(
      text: "I found them on a park bench near the entrance.",
      isSentByMe: false,
      time: "10:32 AM",
    ),
    Message(
      text: "Are those really mine?",
      isSentByMe: true,
      time: "10:33 AM",
    ),
    Message(
      text: "Yes, those are yours! I found them on a park bench.",
      isSentByMe: false,
      time: "10:34 AM",
    ),
    Message(
      text: "You have the wallet with blue stitching?",
      isSentByMe: false,
      time: "10:35 AM",
    ),
    Message(
      text: "Yes, with my ID and credit cards inside.",
      isSentByMe: true,
      time: "10:36 AM",
    ),
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(
          Message(
            text: _messageController.text,
            isSentByMe: true,
            time: "Now",
          ),
        );
        _messageController.clear();
      });

      // Scroll to bottom
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Scroll to bottom when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: Text(
                widget.contactName[0],
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.contactName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Online',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Call functionality
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Call User'),
                  content: Text('Would you like to call ${widget.contactName}?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Calling ${widget.contactName}...'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      child: const Text('Call'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.phone),
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: Container(
              color: Colors.grey[50],
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return MessageBubble(
                    message: message,
                    isLastInSequence: index == _messages.length - 1 ||
                        _messages[index + 1].isSentByMe != message.isSentByMe,
                  );
                },
              ),
            ),
          ),

          // Message Input Area
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            decoration: const InputDecoration(
                              hintText: 'Type a message...',
                              border: InputBorder.none,
                            ),
                            onSubmitted: (_) => _sendMessage(),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Add attachment functionality
                          },
                          icon: Icon(
                            Icons.attach_file,
                            color: Colors.grey[600],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Add camera functionality
                          },
                          icon: Icon(
                            Icons.camera_alt,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.blue[800],
                  child: IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class Message {
  final String text;
  final bool isSentByMe;
  final String time;

  Message({
    required this.text,
    required this.isSentByMe,
    required this.time,
  });
}

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isLastInSequence;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isLastInSequence,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: message.isSentByMe
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: isLastInSequence ? 8.0 : 4.0,
            bottom: 4.0,
            left: message.isSentByMe ? 50.0 : 0,
            right: message.isSentByMe ? 0 : 50.0,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
            color: message.isSentByMe
                ? Colors.blue[800]
                : Colors.grey[200],
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
              bottomLeft: message.isSentByMe
                  ? const Radius.circular(20)
                  : const Radius.circular(4),
              bottomRight: message.isSentByMe
                  ? const Radius.circular(4)
                  : const Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.text,
                style: TextStyle(
                  color: message.isSentByMe
                      ? Colors.white
                      : Colors.black87,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                message.time,
                style: TextStyle(
                  color: message.isSentByMe
                      ? Colors.white.withOpacity(0.7)
                      : Colors.grey[600],
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

 */