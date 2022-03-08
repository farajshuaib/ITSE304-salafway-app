
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'package:radio/quran/components/quran_playlist.dart';

class Reader extends StatefulWidget {
  final String readerId;
  final bool isLocal;
  Reader({Key? key, required this.readerId,required this.isLocal}) : super(key: key);

  @override
  State<Reader> createState() => _ReaderState();
}

class _ReaderState extends State<Reader> {

  var surahs = [];

  bool loading = true;

  void loadRemoteData() async {
    try {
      var url = Uri.parse(
          'https://qurani-api.herokuapp.com/api/reciters/${widget.readerId}');
      var response = await http.get(url);

      var responseData = jsonDecode(response.body);
      setState(() {
        surahs = responseData['surasData'];
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
  void loadLocalData()  async {
    loading = false;
    var jsonInput = await rootBundle.loadString('asset/localData/quran.json');
    var responseData = json.decode(jsonInput);
    setState(() => surahs = responseData['surasData']);

  }

  initState() {
    if(widget.isLocal){
      loadLocalData();
    }else{
      loadRemoteData();
    }

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('القرآن الكريم'),
        backgroundColor: Color(0xFF2A5089),
      ),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        child: loading
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              )
            : QuranPlaylist(surahs: surahs,isLocal: widget.isLocal,),
      ),
    );
  }
}
