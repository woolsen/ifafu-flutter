import 'package:flutter/material.dart';
import 'package:ifafu/http/api.dart';
import 'package:ifafu/http/model.dart' as model;
import 'package:ifafu/widget/post.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';


class MyPostPage extends StatefulWidget {
  const MyPostPage({super.key});

  @override
  State<StatefulWidget> createState() => _MyPostPageState();
}

class _MyPostPageState extends State<MyPostPage> {

  static const _pageSize = 10;

  final PagingController<int, model.Post> _pagingController =
      PagingController(firstPageKey: 0);


  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的帖子'),
      ),
      body: PagedListView.separated(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<model.Post>(
          itemBuilder: (context, item, index) => Post(post: item),
        ),
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(thickness: 0.5);
        },
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await Api.instance.getMyPosts(pageKey, _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }
}
