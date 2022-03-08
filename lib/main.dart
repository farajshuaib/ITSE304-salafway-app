import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:lottie/lottie.dart';

import 'home/homePage.dart';
import 'radio/live_radio.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  @override
  initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    LiveRadio(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("ar", "LY"),
      ],
      locale: Locale("ar", "LY"),
      title: 'طريق السلف',
      theme: ThemeData(
        primaryColor: Color(0xFF2A5592),
        // textTheme: GoogleFonts.tajawalTextTheme(
        //   Theme.of(context).textTheme,
        // ),
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'طريق السلف',
            style: TextStyle(fontFamily: "Hero", fontSize: 35),
          ),
          backgroundColor: Color(0xFF2A5089),
        ),
        body: Container(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.radio),
              label: 'الراديو',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFF2A5592),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
