import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:radio/home/components/reciters.dart';
import '../quran/components/reader.dart';
import 'components/header.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ConnectivityResult? _connectivityResult;
  var listOfReciters = [];
  bool loading = true;
  bool isLocal = false;

  Future<bool> _checkConnectivityState() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();

    print("connection resultx $result");
    if (result == ConnectivityResult.wifi) {
      return true;
    } else if (result == ConnectivityResult.mobile) {
      return true;
    } else {
      return false;
    }
  }

  void loadRemoteData() async {
    if (await _checkConnectivityState()) {
      try {
        var url = Uri.parse('https://qurani-api.herokuapp.com/api/reciters');
        var response = await http.get(url);
        setState(() {
          listOfReciters = jsonDecode(response.body);
          loading = false;
        });
      } catch (err) {
        setState(() {
          loading = false;
        });

        loadLocalData();

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text("حدث خطأ ما في جلب البيانات, انت الان في وضع اوفلاين")));
      }
    } else {
      loadLocalData();
    }
  }

  void loadLocalData() async {
    try {
      var jsonText =
          await rootBundle.loadString('assets/localData/reciters.json');
      print(jsonText);
      setState(() {
        loading = false;
        isLocal = true;
      });
      setState(() => listOfReciters = json.decode(jsonText));
    } catch (err) {
      setState(() {
        loading = false;
        isLocal = true;
      });
      print(err);
    }
  }

  @override
  initState() {
    loadRemoteData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: double.infinity,
      child: loading
          ? Center(
              child: Lottie.asset(
              "assets/loading.json",
            )
              // CircularProgressIndicator(
              //   color: Theme.of(context).primaryColor,
              // ),
              )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(isLocal: isLocal),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "اختار قارئك المفضل",
                      style: TextStyle(
                        fontFamily: "title",
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  AllReciters(
                    listOfReciters: listOfReciters,
                    isLocal: isLocal,
                  )
                ],
              ),
            ),
    );
  }
}
