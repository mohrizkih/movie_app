import 'package:flutter/material.dart';

class MyLeading extends StatelessWidget {
  const MyLeading({
    Key? key,
    this.color,
  }) : super(key: key);
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(maxWidth: 20),
      onPressed: () {
        Navigator.pop(context);
      },
      icon: CircleAvatar(
          foregroundColor: Colors.white,
          backgroundColor: color ?? Colors.green.shade800,
          radius: 15,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 18,
            ),
          )),
    );
  }
}
