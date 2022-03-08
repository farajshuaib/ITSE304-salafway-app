import 'package:flutter/material.dart';

class Header extends StatelessWidget {

  bool isLocal ;
   Header({required this.isLocal,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(14),
      height: 240,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
      ),
      child: isLocal ?
      Image.asset('assets/quran_header.jpeg')
      : Image.network('https://equranacademy.com/wp-content/uploads/2018/08/Holy-Quran-Learning-1024x576.jpeg',
        fit: BoxFit.cover,
      ),
    );
  }
}
