import 'package:flutter/material.dart';

class BeautifulSupportChatScreen extends StatefulWidget {
  @override
  State<BeautifulSupportChatScreen> createState() => _BeautifulSupportChatScreenState();
}

class _BeautifulSupportChatScreenState extends State<BeautifulSupportChatScreen> {
  final List<Map<String, String>> messages = [
    {'from': 'soporte', 'text': '¡Hola! ¿En qué podemos ayudarte hoy?'},
  ];
  final TextEditingController _controller = TextEditingController();

  void sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      messages.add({'from': 'usuario', 'text': _controller.text.trim()});
      _controller.clear();
      Future.delayed(Duration(milliseconds: 800), () {
        setState(() {
          messages.add({'from': 'soporte', 'text': 'Gracias por tu mensaje. Un agente te responderá pronto.'});
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181818),
      appBar: AppBar(
        backgroundColor: Color(0xFF181818),
        elevation: 0,
        title: Text('Chat con Soporte', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(18),
              itemCount: messages.length,
              itemBuilder: (context, idx) {
                final msg = messages[idx];
                final isUser = msg['from'] == 'usuario';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blueAccent : Color(0xFF232323),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(msg['text'] ?? '', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                );
              },
            ),
          ),
          Container(
            color: Color(0xFF232323),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Escribe tu mensaje...',
                      hintStyle: TextStyle(color: Colors.white54),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      filled: true,
                      fillColor: Color(0xFF181818),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                  onPressed: sendMessage,
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}