import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/util/custom_colors.dart';

class CustomBottomNavBar extends StatefulWidget {
  final VoidCallback onMiddleButtonPressed;
  const CustomBottomNavBar({super.key, required this.onMiddleButtonPressed});

  @override
  State<CustomBottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 105,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                  border: Border.all(
                    color: Color(0xFF595959).withOpacity(0.5),
                  )),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        icon: const Column(
                          children: [
                             ImageIcon(
                                AssetImage("assets/icons/nav_bar_home_icon.png"),
                                color: CustomColors.pink),
                              Text("홈", style: TextStyle(fontSize: 12, color:CustomColors.pink)),
                          ],
                        ),
                        onPressed: () {}),
                    IconButton(
                        icon: const Column(
                          children: [
                             ImageIcon(AssetImage(
                                "assets/icons/nav_bar_location_icon.png")),
                                Text("스팟", style:TextStyle(fontSize: 12, color:CustomColors.secondaryBlack)),
                          ],
                        ),
                        onPressed: () {}),
                    const SizedBox(),
                    IconButton(
                        icon: const Column(
                          children: [
                             ImageIcon(
                                AssetImage("assets/icons/nav_bar_chat_icon.png")),
                                                                Text("채팅", style:TextStyle(fontSize: 12, color:CustomColors.secondaryBlack)),

                          ],
                        ),
                        onPressed: () {}),
                    IconButton(
                        icon: const Column(
                          children: [
                             ImageIcon(AssetImage(
                                "assets/icons/nav_bar_profile_icon.png")),
                                Text("마이", style:TextStyle(fontSize: 12, color:CustomColors.secondaryBlack)),
                          ],
                        ),
                        onPressed: () {}),
                  ])),
          Positioned(
              top: -3,
              child: InkWell(
                onTap: () => widget.onMiddleButtonPressed(),
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  "assets/icons/nav_bar_star_icon.png",
                  width: 65,
                ),
              ))
        ],
      ),
    );
  }
}
