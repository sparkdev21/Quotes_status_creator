import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quotes_status_creator/Monetization/NativeAds/native_banner.dart';

class SubmitQuotesPage extends StatefulWidget {
  final String title;
  const SubmitQuotesPage({Key? key, required this.title}) : super(key: key);

  @override
  _SubmitQuotesPageState createState() => _SubmitQuotesPageState();
}

class _SubmitQuotesPageState extends State<SubmitQuotesPage> {
  List<String> attachments = [];
  bool isHTML = false;

  final _subjectController = TextEditingController(text: '');

  final _bodyController = TextEditingController(
    text: '',
  );

  Future<void> send() async {
    String platformResponse;

    final Email email = Email(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: ['aoneapps1+userQuotes@gmail.com'],
    );
    if (!mounted) return;

    try {
      await FlutterEmailSender.send(email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Successfully Sent",
            textAlign: TextAlign.center,
          ),
        ),
      );
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          ' Submit Your Quotes',
          style: TextStyle(fontSize: 16),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: send,
            icon: const Icon(Icons.send),
          )
        ],
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 4),
            child: const NativeBanner(),
          ),
          SizedBox(
            height: 8,
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                textInputAction: TextInputAction.next,
                controller: _subjectController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _bodyController,
                maxLines: null,
                expands: true,
                textInputAction: TextInputAction.done,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                    hintText: 'Your Quotes Here',
                    labelText: 'Your Quote',
                    border: OutlineInputBorder()),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                    onPressed: send,
                    child: Text(
                      "Send",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        child: const Icon(FontAwesomeIcons.paperPlane),
        onPressed: send,
      ),
    );
  }
}
