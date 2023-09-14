import 'package:flutter_with_firebase/util/view_util.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/model/snapshot_model.dart';
import 'package:flutter_with_firebase/util/custom_colors.dart';
import 'package:firebase_database/firebase_database.dart';

import 'individual_suitor.dart';

class Suitors extends StatefulWidget {
  const Suitors({super.key});

  @override
  State<Suitors> createState() => _SuitorsState();
}

class _SuitorsState extends State<Suitors> {
  List<Snapshot> snapshots = [];

  listen() async {
    final ref =  FirebaseDatabase.instance.ref('data');

    ref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      snapshots = _parseData(data);
      // updateStarCount(data);
      setState(() {});
    });
  }

  List<Snapshot> _parseData(Object? dataSnapshot) {
    var list = <Snapshot>[];
    var mapOfMaps = Map<String, dynamic>.from(dataSnapshot as Map);

    for (var value in mapOfMaps.values) {
      list.add(Snapshot.fromJson(Map.from(value)));
    }
    return list;
  }

  final _controller = PageController(viewportFraction: 0.9, initialPage: 0);

  @override
  void initState() {
    super.initState();
    listen();
  }

  bool showLastSlide = false;
  @override
  Widget build(BuildContext context) {
     
    return PageView.builder(
      allowImplicitScrolling: true,
      controller: _controller,
      itemCount: snapshots.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          decoration: BoxDecoration(
              border: Border.all(color: CustomColors.strokeColor, width: 1.5),
              borderRadius: BorderRadius.circular(20)),
          child: Stack(
            children: [
              IndividualSuitor(images: snapshots[index].images!),
              Positioned.fill(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 200,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.black, Colors.transparent])),
                ),
              )),
              suitorDetails(snapshots[index]),
              Positioned(
                  bottom: 1,
                  left: 0,
                  right: 0,
                  child: IconButton(
                    icon: const ImageIcon(
                      AssetImage("assets/icons/down_arrow_icon.png"),
                      size: 10,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  )),
            ],
          ),
        );
      },
    );
  }

  Widget suitorDetails(Snapshot details) {
    return Positioned(
        bottom: 80,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ViewUtil.starWidget(
                  textCount: details.likeCount ?? 0,
                  liked: false,
                  withBorder: false,
                  starSize: 16,
                  textSize: 18),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                          crossAxisAlignment: WrapCrossAlignment.end,
                          alignment: WrapAlignment.end,
                          runAlignment: WrapAlignment.end,
                          spacing: 5,
                          children: [
                            Text(
                              details.name ?? '',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 32),
                            ),
                            Text(details.age.toString(),
                                textAlign: TextAlign.end,
                                style: const TextStyle(fontSize: 20))
                          ]),
                      Wrap(
                        children: [
                          Text(
                            details.location ?? '',
                            style: const TextStyle(
                                fontFamily: "Pretendard",
                                fontWeight: FontWeight.w300),
                          ),
                          const Text("  "),
                          Text(details.description ?? '',
                              style: const TextStyle(
                                  fontFamily: "Pretendard",
                                  fontWeight: FontWeight.w300)),
                        ],
                      ),
                      for (String i in details.tags ?? []) Text(i)
                    ],
                  ),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(right: 25),
                          child: likeContainer())),
                ],
              ),
            ],
          ),
        ));
  }

  Widget likeContainer() {
    return Container(
      width: 60,
      height: 60,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        border: GradientBoxBorder(
          gradient:
              LinearGradient(colors: [Color(0xFF45FFF4), Color(0xFF7000FF)]),
          width: 1.5,
        ),
      ),
      child: Center(
        child: Image.asset("assets/icons/favorite_icon.png", width: 18.21),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
