import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import "./Home.dart";
import './live_radio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ConnectivityResult? _connectivityResult;
  late StreamSubscription _connectivitySubscription;
  int _selectedIndex = 0;

  Future<void> _checkConnectivityState() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.wifi) {
      print('Connected to a Wi-Fi network');
    } else if (result == ConnectivityResult.mobile) {
      print('Connected to a mobile network');
    } else {
      print('Not connected to any network $result ');
    }

    setState(() {
      _connectivityResult = result;
    });
  }

  @override
  initState() {
    super.initState();
    // watch the internet connection
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      print('Current connectivity status: $result');
      _connectivityResult = result;
    });
  }

  @override
  dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
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
            title: const Text('طريق السلف'),
            // elevation: 0,
            backgroundColor: Color(0xFF2A5089),
          ),
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'الرئيسية',
                backgroundColor: Colors.red,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.radio),
                label: 'الراديو',
                backgroundColor: Colors.green,
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Color(0xFF2A5592),
            onTap: _onItemTapped,
          ),
        ));
  }
}
