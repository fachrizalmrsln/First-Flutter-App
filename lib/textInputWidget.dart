import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {
  final Function(String) callback;

  TextInputWidget(this.callback);

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.controller,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.message),
        labelText: "Type a message in here",
        suffixIcon: IconButton(
          icon: Icon(Icons.send),
          splashColor: Colors.redAccent,
          tooltip: "Sending a message",
          onPressed: this.onClickButton,
        ),
      ),
    );
  }

  void onClickButton() {
    widget.callback(controller.text);
    controller.clear();
  }
}
