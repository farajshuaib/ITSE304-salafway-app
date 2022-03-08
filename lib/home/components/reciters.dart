import 'package:flutter/material.dart';
import 'package:radio/quran/components/reader.dart';

class AllReciters extends StatelessWidget {

  var listOfReciters ;
  bool isLocal;

  AllReciters({@required this.listOfReciters,required this.isLocal, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: listOfReciters.length,
        itemBuilder: (BuildContext context, int index) {
          String readerId = listOfReciters[index]!['id'];

          return ListTile(
            title: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Reader(readerId:readerId,isLocal: isLocal)),
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
                        "${listOfReciters[index]['name']}",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "title",
                            color: Colors.black
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${listOfReciters[index]['rewaya']}",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )),
            ),
          );
        },
      ),
    );
  }
}
