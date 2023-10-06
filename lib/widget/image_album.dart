import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ifafu/page/image_viewer.dart';
// import 'package:ifafu/widget/transition.dart';

class ImageAlbum extends StatelessWidget {
  final int oneLineMax;
  final int oneLineMin;
  final List<String> imageUrls;

  /// 用于防止页面过渡时不必要的动画
  final String? heroTagAddition;

  const ImageAlbum({
    Key? key,
    required this.oneLineMin,
    required this.oneLineMax,
    required this.imageUrls,
    this.heroTagAddition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) {
      return const SizedBox();
    }
    return LayoutBuilder(builder: (context, constraints) {
      final double size;
      final int lineCount;
      if (imageUrls.length <= oneLineMin) {
        lineCount = oneLineMin;
        size = (constraints.maxWidth - (lineCount - 1) * 4) / oneLineMin;
      } else {
        lineCount = oneLineMax;
        size = (constraints.maxWidth - (lineCount - 1) * 4) / oneLineMax;
      }
      final widgets = <Widget>[];
      var row = <Widget>[];
      var first = true;
      for (var url in imageUrls) {
        if (row.length == lineCount * 2 - 1) {
          row.add(const SizedBox(height: 4));
          widgets.add(Row(children: row));
          row = <Widget>[];
          first = true;
        }
        if (first) {
          first = false;
        } else {
          row.add(const SizedBox(width: 4));
        }
        row.add(GestureDetector(
          onTap: () {
            _goToImageViewer(context, imageUrls.indexOf(url));
          },
          child: Hero(
            tag: '$heroTagAddition#$url',
            createRectTween: (begin, end) {
              return RectTween(begin: begin, end: end);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size / 16),
              child: CachedNetworkImage(
                imageUrl: url,
                height: size,
                width: size,
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return const Center(
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
                httpHeaders: {
                  'sec-fetch-platform': Platform.operatingSystem,
                },
              ),
            ),
          ),
        ));
      }
      widgets.add(const SizedBox(height: 4));
      widgets.add(Row(children: row));
      return Column(children: widgets);
    });
  }

  _goToImageViewer(BuildContext context, int index) {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, __) {
          return ImageViewer(
            currentIndex: index,
            items: imageUrls.map((url) {
              return ImageItem(
                imageUrl: url,
                tag: '$heroTagAddition#$url',
              );
            }).toList(growable: false),
          );
        },
      ),
    );
  }
}
