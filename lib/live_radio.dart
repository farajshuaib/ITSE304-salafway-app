import 'package:flutter/material.dart';
import "./Streaming_controller.dart";

class LiveRadio extends StatefulWidget {
  LiveRadio({Key? key}) : super(key: key);

  @override
  State<LiveRadio> createState() => _LiveRadioState();
}

class _LiveRadioState extends State<LiveRadio> {
  var streamingController = StreamingController();

  @override
  void initState() {
    super.initState();
    streamingController.config(
        url: "http://160.19.99.214:8000/fm"); // salfway fm
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                    child: Image(
                      image: NetworkImage(
                          'https://www.salafway.ly/assets/img/logo.png'),
                    ),
                  )
                ],
              ),
            ),
            SizedBox.expand(
              child: DraggableScrollableSheet(
                initialChildSize: 0.3,
                maxChildSize: 0.85,
                minChildSize: 0.3,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ListView(
                            controller: scrollController,
                            children: [
                              SizedBox(
                                height: 45,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "طريق السلف",
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Color(0xff2D2E2F),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "100.3",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff2D2E2F),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                height: 25,
                                thickness: 1,
                                indent: 0,
                                endIndent: 0,
                              ),
                              Text(
                                "حول قناة طريق السلف",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.3,
                                  color: Color(0xff2D2E2F),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1.3,
                                  color: Color(0xff2D2E2F),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.phone_android_outlined,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "+218911234567",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff2D2E2F),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.mail_outline,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "info@salafway.ly",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff2D2E2F),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.pin_drop_outlined,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "طرابلس - ليبيا",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff2D2E2F),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                              const Divider(
                                height: 25,
                                thickness: 1,
                                indent: 0,
                                endIndent: 0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: -45.0,
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff2D2E2F),
                            border: Border.all(
                                width: 5,
                                color: Theme.of(context).primaryColor),
                          ),
                          child: StreamBuilder(
                            stream:
                                streamingController.streamingController.stream,
                            builder: (BuildContext context, snapshot) {
                              print(snapshot.data);
                              if (snapshot.data == null ||
                                  snapshot.data == "paused_event") {
                                return IconButton(
                                  icon: Icon(
                                    Icons.play_arrow,
                                    size: 44,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    streamingController.play();
                                  },
                                );
                              } else if (snapshot.data == "playing_event") {
                                return IconButton(
                                  icon: Icon(
                                    Icons.pause,
                                    size: 44,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    streamingController.pause();
                                  },
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
