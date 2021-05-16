import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  AuthTextField(
      {this.label,
      @required this.controller,
      this.type = TextInputType.text,
      this.isPassword = false,
      this.onEditingComplete});
  final TextInputType type;
  final String label;
  final bool isPassword;
  final void Function() onEditingComplete;

  final TextEditingController controller;

  @override
  _AuthTextFieldState createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool showPassword;
  @override
  void initState() {
    super.initState();
    showPassword = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextFormField(
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
        obscureText: showPassword,
        controller: widget.controller,
        keyboardType: widget.type,
        cursorColor: Colors.blue[200],
        onEditingComplete: widget.onEditingComplete,
        onChanged: (value) {
          setState(
            () {},
          );
        },
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: (widget.label == null) ? "" : widget.label,
          // hintStyle: TextStyle(fontSize: 11),
          filled: true,
          fillColor: (widget.controller.text.length > 0)
              ? Colors.blue[200]
              : Colors.transparent, //Color(0xffE4E3E3),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: (widget.controller.text.length > 0)
                  ? Colors.transparent
                  : Colors.black,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(6.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: (widget.controller.text.length > 0)
                  ? Colors.transparent
                  : Colors.black,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(6.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: (widget.controller.text.length > 0)
                  ? Colors.transparent
                  : Colors.black,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(6.0),
            ),
          ),
        ),
      ),
    );
  }
}
