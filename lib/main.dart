import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: const MyHomePage(title: 'Zenn Slack API'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  final Uri url = Uri.parse(
      "https://hooks.slack.com/services/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");
  Map<String, String> headers = {
    'content-type': 'application/json',
  };

  void _sendSlackApi() async {
    Map<String, String> postData = {"text": _controller.text};
    String body = jsonEncode(postData);
    http.Response response = await http.post(url, headers: headers, body: body);
    print("response[statusCode]:${response.statusCode}");
    print("response[headers]:${response.headers}");
    print("response[body]:${response.body}");
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _controller,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendSlackApi,
        child: const Icon(Icons.add),
      ),
    );
  }
}
