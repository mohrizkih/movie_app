import 'package:flutter/material.dart';

class OtherDescription extends StatelessWidget {
  const OtherDescription({
    Key? key,
    required this.iconData,
    required this.title,
    required this.description,
  }) : super(key: key);
  final IconData iconData;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(iconData, color: Colors.amber),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w400, color: Colors.green.shade800, fontSize: 14),
              ),
              Text(
                description,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              )
            ],
          ),
        ],
      ),
    );
  }
}
