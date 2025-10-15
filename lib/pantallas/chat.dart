import 'package:flutter/material.dart';
import '../widgets/safe_back_appbar.dart';

class BeautifulChatScreen extends StatelessWidget {
  final List<Map<String, dynamic>> chat = [
    {'text': 'Hola, ¿cómo va el avance?', 'isMe': false},
    {'text': '¡Hola! Vamos genial, ya casi terminamos.', 'isMe': true},
    {'text': 'Perfecto, avísame si necesitan ayuda.', 'isMe': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A1A2F),
      appBar: SafeBackAppBar(title: 'Chat del Proyecto'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: ListView.builder(
          itemCount: chat.length,
          itemBuilder: (context, i) {
            final msg = chat[i];
            return Align(
              alignment: msg['isMe'] ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                decoration: BoxDecoration(
                  color: msg['isMe'] ? Colors.blueAccent : Color(0xFF142A47),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: msg['isMe'] ? Colors.blueAccent.withOpacity(0.2) : Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(msg['text'], style: TextStyle(color: msg['isMe'] ? Colors.white : Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
              ),
            );
          },
        ),
      ),
    );
  }
}
