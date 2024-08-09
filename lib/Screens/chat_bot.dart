import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';

class BotScreen extends StatefulWidget {
  const BotScreen({super.key});

  @override
  State<BotScreen> createState() => _BotScreenState();
}

class _BotScreenState extends State<BotScreen> {
  final TextEditingController _userMessage = TextEditingController();

  static const apiKey = "AIzaSyCdBRFDT0HtiNY-a-t3Q4C60lGnXC59b1o";

  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

  final List<Message> _messages = [];
  bool _isLoading = false;

  Future<void> sendMessage() async {
    final message = _userMessage.text;
    _userMessage.clear();

    setState(() {
      _messages.add(Message(isUser: true, message: message, date: DateTime.now()));
      _isLoading = true;
    });

    // Simulate a delay for loading animation
    await Future.delayed(Duration(seconds: 1));

    final content = [Content.text(message)];
    final response = await model.generateContent(content);
    setState(() {
      _messages.add(Message(isUser: false, message: response.text ?? "No response", date: DateTime.now()));
      _isLoading = false;
    });
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final file = File(image.path);
      final bytes = await file.readAsBytes();
      final base64Image = base64Encode(bytes);

      final imageMessage = Message(
        isUser: true,
        message: base64Image,
        date: DateTime.now(),
        isImage: true,
      );

      setState(() {
        _messages.add(imageMessage);
        _isLoading = true;
      });
      // Simulate a delay for loading animation
      await Future.delayed(Duration(seconds: 1));

      // Gemini API response for image
      final response = await model.generateContent(
        [Content.text("Image sent")]
      );

      setState(() {
        _messages.add(Message(
          isUser: false,
          message: response.text ?? "Image received",
          date: DateTime.now(),
        ));
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Enter Your Symptoms Below..!!',
          style: TextStyle(
            color: Colors.deepPurple,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey[50],
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.grey[100],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return Messages(
                      isUser: message.isUser,
                      message: message.message,
                      date: DateFormat('HH:mm').format(message.date),
                      isImage: message.isImage,
                    );
                  },
                ),
              ),
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 10),
                      Text('Gemini is typing...'),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _userMessage,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Ask Gemini...",
                          hintStyle: TextStyle(color: Colors.grey[600]),
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                    const SizedBox(width: 10),
                    FloatingActionButton(
                      onPressed: sendMessage,
                      backgroundColor: Colors.deepPurple,
                      child: const Icon(Icons.send, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    FloatingActionButton(
                      onPressed: _pickImage,
                      backgroundColor: Colors.deepPurple,
                      child: const Icon(Icons.image, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;
  final bool isImage;

  const Messages({
    super.key,
    required this.isUser,
    required this.message,
    required this.date,
    this.isImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 5).copyWith(
        left: isUser ? 60 : 10,
        right: isUser ? 10 : 60,
      ),
      decoration: BoxDecoration(
        color: isUser ? Colors.deepPurple : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: isUser ? Radius.circular(30) : Radius.zero,
          topRight: Radius.circular(30),
          bottomRight: isUser ? Radius.zero : Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isImage
              ? Image.memory(
                  base64Decode(message),
                  fit: BoxFit.cover,
                  width: 200, 
                  height: 200, 
                )
              : Text(
                  message,
                  style: TextStyle(
                    color: isUser ? Colors.white : Colors.black87,
                    fontSize: 16,
                  ),
                ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              date,
              style: TextStyle(
                color: isUser ? Colors.white70 : Colors.black54,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final bool isUser;
  final String message;
  final DateTime date;
  final bool isImage; 

  Message({
    required this.isUser,
    required this.message,
    required this.date,
    this.isImage = false,
  });
}
