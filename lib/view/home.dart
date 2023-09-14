import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/util/custom_colors.dart';
import 'package:flutter_with_firebase/view/suitors.dart';

import '../util/view_util.dart';
import 'bottom_nav_bar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool showDefaultPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      bottomNavigationBar:  CustomBottomNavBar(onMiddleButtonPressed: ()=>
        setState(()=> showDefaultPage = false)
      ),
      body: SafeArea(
        child: Column(children: [
          _titleSection(),
          Expanded(
              child: showDefaultPage
                  ? defaultPage()
                  : Dismissible(
                      direction: DismissDirection.vertical,
                      key: const Key('key'),
                      onDismissed: (direction) {  
                          showDefaultPage = true;
                          setState(() {});
                      },
                      child: const Suitors())),
        ]),
      ),
    );
  }

  Widget _titleSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/location_on_icon.png",
              width: 14.03,
            ),
            const SizedBox(width: 7),
            const Text("목이길어슬픈기린님의 새로운 스팟"),
            const Spacer(),
            ViewUtil.starWidget(
                textCount: 323233,
                liked: true,
                withBorder: true,
                starSize: 18,
                textSize: 16),
            Image.asset("assets/icons/notification_icon.png", height: 30),
          ]),
    );
  }

  Widget defaultPage() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("추천 드릴 친구들을 준비 중이에요",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27)),
        SizedBox(height: 17),
        Text("매일 새로운 친구들을 소개시켜드려요",
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16))
      ],
    );
  }
}
