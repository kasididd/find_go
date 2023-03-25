import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:ux_ui_find_go/utility/colors.dart';
import 'package:ux_ui_find_go/widget/assist_widget.dart';

class ChatePage extends StatefulWidget {
  const ChatePage({super.key});

  @override
  State<ChatePage> createState() => _ChatePageState();
}

class _ChatePageState extends State<ChatePage> {
  TextEditingController senddingValue = TextEditingController();
  @override
  void dispose() {
    senddingValue.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  bool typing = false;
  // TODO add data message to database
  List<Message> messages = [
    Message(
        text: "hello",
        date: DateTime.now().subtract(const Duration(days: 2, minutes: 1)),
        isSentByMe: false),
    Message(
        text: "hello",
        date: DateTime.now().subtract(const Duration(days: 3, minutes: 1)),
        isSentByMe: true),
  ];
  late FocusNode myFocusNode;
  @override
  void initState() {
    myFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: BasicAppbar(title: "Chate")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // recive
              ChatField(messages: messages),
              keyBoardType(),
            ],
          ),
        ),
      ),
    );
  }

  Container keyBoardType() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade300,
      ),
      child: TextField(
        focusNode: myFocusNode,
        autofocus: true,
        controller: senddingValue,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(12),
          hintText: "Type your message here...",
          suffixIcon: IconButton(
            onPressed: () => senddingValue.clear(),
            icon: Icon(
              Icons.clear,
              color: typing ? Colors.grey.shade900 : Colors.grey.shade300,
            ),
          ),
        ),
        onChanged: (value) => setState(() {
          value.isNotEmpty ? typing = true : typing = false;
        }),
        onSubmitted: senddingValue.text.length == 0
            ? null
            : (value) {
                final message = Message(
                    text: value, date: DateTime.now(), isSentByMe: true);
                setState(() {
                  messages.add(message);
                  typing = false;
                  senddingValue.clear();
                });
                myFocusNode.requestFocus();
              },
      ),
    );
  }
}

class ChatField extends StatelessWidget {
  const ChatField({
    super.key,
    required this.messages,
  });

  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GroupedListView<Message, DateTime>(
      reverse: true,
      order: GroupedListOrder.DESC,
      elements: messages,
      groupBy: (element) => DateTime(
        element.date.year,
        element.date.month,
        element.date.day,
      ),
      groupHeaderBuilder: (Message element) => Center(
        child: Card(
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              DateFormat.yMMMMd().format(element.date),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      itemBuilder: (context, Message element) => Align(
        alignment:
            element.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Card(
            color:
                element.isSentByMe ? kBackgroundGreen : Colors.purple.shade200,
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                element.text,
                style: TextStyle(
                  color: element.isSentByMe ? Colors.white : Colors.black,
                ),
              ),
            )),
      ),
    ));
  }
}

class Message {
  final String text;
  final DateTime date;
  final bool isSentByMe;
  const Message({
    required this.text,
    required this.date,
    required this.isSentByMe,
  });
}
