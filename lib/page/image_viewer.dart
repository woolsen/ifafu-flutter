import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageViewer extends StatelessWidget {
  final List<ImageItem> items;
  final int? currentIndex;
  final ValueChanged<int>? onPageChanged;
  final PageController? _pageController;
  final ImageProvider Function(String)? imageProviderBuilder;

  ImageViewer({
    super.key,
    required this.items,
    this.currentIndex,
    this.onPageChanged,
    this.imageProviderBuilder,
  }) : _pageController = PageController(initialPage: currentIndex ?? 0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        pageController: _pageController,
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: imageProviderBuilder != null
                ? imageProviderBuilder!(items[index].imageUrl)
                : CachedNetworkImageProvider(items[index].imageUrl),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 4.1,
            heroAttributes: PhotoViewHeroAttributes(
              tag: items[index].tag ?? '',
              createRectTween: (begin, end) {
                return RectTween(begin: begin, end: end);
              },
            ),
          );
        },
        itemCount: items.length,
      ),
    );
  }
}

class ImageItem {
  final String imageUrl;
  final Object? tag;

  ImageItem({required this.imageUrl, this.tag});
}
