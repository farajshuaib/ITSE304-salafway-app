import 'package:flutter/material.dart';

class RadioDescription extends StatelessWidget {
  final ScrollController scrollController;

  RadioDescription({required this.scrollController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 45,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "طريق السلف",
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xff2D2E2F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "100.3",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2D2E2F),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
