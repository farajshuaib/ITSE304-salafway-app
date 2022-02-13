import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import './reader.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var data = [];
  bool loading = true;

  getData() async {
    try {
      var url = Uri.parse('https://qurani-api.herokuapp.com/api/reciters');
      var response = await http.get(url);
      setState(() {
        data = jsonDecode(response.body);
        loading = false;
      });
    } catch (err) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text("حدث خطأ ما في جلب البيانات الرجاء إعادة المحاولة لاحقا")));
    }
  }

  initState() {
    getData();
    super.initState();
  }

  Widget Header() {
    return Container(
      margin: EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Image(
        fit: BoxFit.cover,
        height: 240.0,
        image: AssetImage(
            "https://media.istockphoto.com/photos/quran-in-the-mosque-picture-id482765777?k=20&m=482765777&s=612x612&w=0&h=FbG6NPscHKTqlj3uOs5z_0ONb19wNtGtVXrmhlPVjqw="),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          height: double.infinity,
          child: loading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              : Container(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Reader(reader_id: data[index]['id'])),
                              );
                            },
                            child: Container(
                                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                                margin: EdgeInsets.only(bottom: 10, top: 10),
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          spreadRadius: 1,
                                          blurRadius: 3)
                                    ]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data[index]['name']}",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      "${data[index]['rewaya']}",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        );
                      }),
                ),
        ),
      ],
    );
  }
}
