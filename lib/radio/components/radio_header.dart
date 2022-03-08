import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RadioHeader extends StatelessWidget {
  const RadioHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 70.0),
      child: Column(
        children: [
          Icon(CupertinoIcons.antenna_radiowaves_left_right,size: 50,color: Colors.white,),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              width: 350,
              child: Text(
                """  الَّذِينَ آمَنُوا وَتَطْمَئِنُّ قُلُوبُهُم بِذِكْرِ اللَّهِ ۗ أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوب الرعد """,
                  style: TextStyle(fontFamily: "title",color: Colors.white,fontSize: 25,
                      letterSpacing:1.3,

                  ),textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
