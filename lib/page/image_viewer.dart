import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageViewer extends StatefulWidget {
  final List<ImageItem> items;
  final int? currentIndex;
  final ValueChanged<int>? onPageChanged;

  const ImageViewer({
    super.key,
    required this.items,
    this.currentIndex,
    this.onPageChanged,
  });

  @override
  State<StatefulWidget> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {

  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.currentIndex ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        pageController: _pageController,
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: CachedNetworkImageProvider(
              widget.items[index].imageUrl,
            ),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 4.1,
            heroAttributes: PhotoViewHeroAttributes(
              tag: widget.items[index].tag ?? '',
            ),
          );
        },
        itemCount: widget.items.length,
      ),
    );
  }

}


class ImageItem {
  final String imageUrl;
  final String? tag;

  ImageItem({required this.imageUrl, this.tag});
}
