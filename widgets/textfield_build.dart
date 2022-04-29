// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class My_Textfield extends StatelessWidget {
  final String hint;
  final TextEditingController con;

  const My_Textfield({
    Key? key,
    required this.hint,
    required this.con,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.withOpacity(.3),
      margin: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: TextField(
        controller: con,
        minLines: 1,
        maxLines: 5,
        cursorColor: Colors.black,
        decoration: InputDecoration(
            hintText: hint,
            border: _outtline(),
            enabledBorder: _outtline(),
            focusedBorder: _outtline()),
      ),
    );
  }

  dynamic _outtline() => OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 4, 4, 4), width: 2),
      );
}
