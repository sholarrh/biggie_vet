

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class InputField extends StatefulWidget {
  final Widget? prefixIcon;
  final String hintText;
  final bool hasSuffixIcon;
  final TextEditingController inputController;
  final bool isPassword;
  final Function? validator;
  final Function? onSaved;
  final TextInputType keyBoardType;
  final TextInputAction? textInputAction;
  const InputField(
      {Key? key,
        required this.inputController,
        required this.isPassword,
        this.prefixIcon,
        required this.hintText,
        required this.hasSuffixIcon,
        this.validator,
        this.onSaved,
        required this.keyBoardType,
        this.textInputAction})
      : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _obscureText = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(.1)),
      ]),
      child: TextFormField(
        validator: (value) => widget.validator!(value),
        controller: widget.inputController,
        onChanged: (value) {
          //Do something wi
        },
        keyboardType: widget.keyBoardType,
        autocorrect: true,
        textCapitalization: TextCapitalization.words,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        onSaved: (value) => widget.onSaved!(value),
        style: TextStyle(
            fontSize: 16, color: mainBlue, fontWeight: FontWeight.w400),
        showCursor: true,
        decoration: InputDecoration(
          fillColor: cardColor,
          prefixIcon: widget.prefixIcon,
          filled: true,
          focusColor: Colors.red,
          hintText: widget.hintText,
          hintStyle: TextStyle(
              color: Colors.grey.withOpacity(.75),
              fontSize: 14,
              fontWeight: FontWeight.bold),
          suffixIcon: widget.hasSuffixIcon == true
              ? GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
                print(_obscureText);
              });
            },
            child: _obscureText
                ? Icon(
              Icons.remove_red_eye_outlined,
              color: Colors.grey,
            )
                : Icon(Icons.visibility_off_outlined),
          )
              : null,
          suffixIconColor: Colors.grey,

          contentPadding:
          const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 0.7),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: mainBlue, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          // enabledBorder: const OutlineInputBorder(
          //   borderSide: BorderSide(color: Color(0xFF333333), width: 0.7),
          //   borderRadius: BorderRadius.all(Radius.circular(15.0)),
          // ),
        ),
        obscureText: _obscureText,
      ),
    );
  }
}




