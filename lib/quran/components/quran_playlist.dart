import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:radio/quran_player/quran_player.dart';

class QuranPlaylist extends StatefulWidget {

  var surahs;
  bool isLocal;

  QuranPlaylist({required this.surahs,required this.isLocal,Key? key}) : super(key: key);

  @override
  State<QuranPlaylist> createState() => _QuranPlaylistState();
}



class _QuranPlaylistState extends State<QuranPlaylist> {

 
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 4/3),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.surahs.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.all(5.0),
              child: GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder:
                    (context) => QuranPlayer(widget.surahs[index],widget.isLocal))),
                child: Container(
                  color: Colors.grey[100],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical:   10.0,
                        horizontal: 10.0
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "سورة",
                              style: TextStyle(
                                fontFamily: "title",
                                fontSize: 17,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(
                              height:25,
                            ),
                            Text(
                              "${widget.surahs[index]['name'].toString()}",
                              style: TextStyle(
                                fontFamily: "Thuluth",
                                fontSize: 44,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff2D2E2F),
                              ),
                            ),

                          ],
                        ),
                        Positioned(
                          bottom: 20,
                          left: 0,
                          top: 20,
                          right: 50,
                          child: Container(
                            child: Center(
                              child: Text(
                                "${widget.surahs[index]['id'].toString()}",
                                style: TextStyle(
                                  fontFamily: "title",
                                  fontSize: 60,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.withOpacity(0.2),

                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}


