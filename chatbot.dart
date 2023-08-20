import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/message.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({Key? key, required String title}) : super(key: key);

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 58, 116, 98),
        title: const Text('Reconnect'),
      ),
      body: Container(
          child: Column(
        children: [
          Expanded(child: MessagesScreen(messages: messages)),
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              color: const Color.fromARGB(255, 43, 165, 139),
              child: Row(children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                        hintText: 'Type a Message...',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white))),
                    autofocus: true,
                    cursorColor: Colors.white,
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                IconButton(
                    color: Colors.white,
                    onPressed: () {
                      sendMessage(_controller.text);
                      _controller.clear();
                    },
                    icon: const Icon(Icons.send))
              ]),
            ),
          )
        ],
      )),
    );
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is Empty');
      Fluttertoast.showToast(msg: 'Message is Empty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) return;
      setState(() {
        addMessage(response.message!);
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
}
