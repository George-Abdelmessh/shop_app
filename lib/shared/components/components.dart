import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton({
  double width = double.infinity,
  double height = 50.0,
  Color background = Colors.blue,
  required Function()? method,
  required String text,
  bool isUpperCase = true,
  double borderRadius = 5.0,

}) => Container(
  width: width,
  height: height,
  child: MaterialButton(
    onPressed: method,
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(
        fontSize: 22,
        color: Colors.white,
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(borderRadius),
    color: background,
  ),
);

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  Function(String)? onChanged,
  Function()? onTap,
  required FormFieldValidator <String> validate,
  required String labelText,
  IconData? prefix,
  IconData? suffix,
  Function()? suffixPressed,
  bool obscureText = false,
  Color textColor = Colors.black,

}) => TextFormField(
  validator: validate,
  onFieldSubmitted: onSubmit,
  onChanged: onChanged,
  controller: controller,
  keyboardType: type,
  obscureText: obscureText,
  onTap: onTap,
  style: TextStyle(
    color: textColor,
  ),
  decoration: InputDecoration(
    labelText: labelText,
    border: OutlineInputBorder(),
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: IconButton(
      onPressed: suffixPressed,
      icon: Icon(suffix),
    ),
  ),
);

Widget defaultTextButton ({
  required Function()? method,
  required String text,
}) => TextButton(
    onPressed: method,
    child: Text(text.toUpperCase())
);

void showToast({
  required String text,
  required TaostState state,
  }) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum TaostState {SUCCESS, ERROR, WARNING}

Color chooseToastColor(TaostState state){

  Color color;

  switch(state){
    case TaostState.SUCCESS:
      color = Colors.green;
      break;
    case TaostState.ERROR:
      color = Colors.red;
      break;
    case TaostState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

void navigateTo (context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish (context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (route) => false,
);