import 'package:flutter/material.dart';

class CollapsedInformation extends StatelessWidget {
  const CollapsedInformation({
    Key? key,
    required this.title,
    required this.overview,
  }) : super(key: key);

  final String title;
  final String overview;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 120,
      child: Column(
        children: [
          Container(
            height: 4,
            margin: EdgeInsets.only(top: 12),
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Color(0xff47623F),
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          overview,
                          maxLines: 4,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
