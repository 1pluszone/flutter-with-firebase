import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../util/custom_colors.dart';

class IndividualSuitor extends StatefulWidget {
  final List<String> images;
  const IndividualSuitor({super.key, required this.images});

  @override
  State<IndividualSuitor> createState() => _IndividualSuitorState();
}

class _IndividualSuitorState extends State<IndividualSuitor> {
  List<Uint8List> rawImages = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return imageWidget(
        widget.images, Size(MediaQuery.of(context).size.width, 80));
  }

  final _contorller = PageController();

  Widget imageWidget(List<String> images, Size s) {
    return GestureDetector(
      onTapUp: (details) {
        int currentPage = (_contorller.page ?? 0).toInt();
        if (details.localPosition.direction > 1.0) {
          if (currentPage != 0) {
            _contorller.jumpToPage(currentPage - 1);
            setState(() {});
          }
        } else if (details.localPosition.direction < 1.0) {
          if (currentPage != widget.images.length - 1) {
            _contorller.jumpToPage(currentPage + 1);
            setState(() {});
          }
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(19),
        child: Stack(
          children: [
            PageView(
              allowImplicitScrolling: true,
              controller: _contorller,
              onPageChanged: (value) => setState(() {}),
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ...images.map((e) {
                  if (e.contains("data:image/jpeg;base64")) {
                    return base64Image(e.split(',')[1]);
                  }
                  return Image.network(
                    e,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, _, __) {
                      return const Center(child: Text("Error loading image"));
                    },
                    loadingBuilder: (_, widget, chuckEvent) {
                      if (chuckEvent != null &&
                          chuckEvent.cumulativeBytesLoaded !=
                              chuckEvent.expectedTotalBytes) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[400]!,
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(4)),
                          ),
                        );
                      } else {
                        return widget;
                      }
                    },
                  );
                }).toList()
              ],
            ),
            Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: widget.images.map((i) {
                          int currentPage = (!_contorller.hasClients
                                  ? 0
                                  : _contorller.page ?? 0)
                              .toInt();
                          bool filled = widget.images.indexOf(i) <= currentPage;
                          return rodContainer(filled: filled);
                        }).toList()),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  SizedBox sizedBox = const SizedBox(width: 10);

  Widget rodContainer({bool filled = false}) {
    return Container(
      height: 3,
      width: 75,
      decoration: BoxDecoration(
          color: filled ? CustomColors.pink : CustomColors.black,
          borderRadius: BorderRadius.circular(1000)),
    );
  }

  Widget base64Image(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  @override
  void dispose() {
    _contorller.dispose();
    super.dispose();
  }
}
