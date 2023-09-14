import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'custom_colors.dart';

class ViewUtil {
  static final formatter = NumberFormat('###,###');
  static final secondFormatter = NumberFormat.decimalPatternDigits(decimalDigits: 0);
  static Widget starWidget(
      {required num textCount,required bool liked, bool withBorder = true, required double starSize, required double textSize}) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
                color: withBorder
                    ? CustomColors.strokeColor
                    : Colors.transparent)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.star,
              color: liked?CustomColors.pink: const Color(0xFF2F2F2F) ,
              size: starSize,
            ),
            const SizedBox(width: 3),
            Text(
              secondFormatter.format(textCount),
              style: TextStyle(fontSize: textSize),
            )
          ],
        ));
  }
}
