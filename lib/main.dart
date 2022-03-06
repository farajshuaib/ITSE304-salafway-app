import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:lottie/lottie.dart';

import "./Home.dart";
import './live_radio.dart';

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
  ConnectivityResult? _connectivityResult;
  int _selectedIndex = 0;

  Future<void> _checkConnectivityState() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();

    print("connection result $result");
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
    _checkConnectivityState();
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
    return _connectivityResult == ConnectivityResult.none
        ? MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Lottie.asset(
                  "assets/42097-no-connection-white.json",
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              ),
            ))
        : MaterialApp(
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
              textTheme: GoogleFonts.tajawalTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            home: Scaffold(
              appBar: AppBar(
                title: const Text('طريق السلف'),
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
            ));
  }
}
