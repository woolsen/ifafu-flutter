import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifafu/http/api.dart';
import 'package:ifafu/http/model.dart' as model;
import 'package:ifafu/provider/user_provider.dart';
import 'package:ifafu/widget/post.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';


class PostMyPage extends StatefulWidget {
  const PostMyPage({super.key});

  @override
  State<StatefulWidget> createState() => _PostMyPageState();
}

class _PostMyPageState extends State<PostMyPage> {

  static const _pageSize = 10;

  final PagingController<int, model.Post> _pagingController =
      PagingController(firstPageKey: 0);

  final postDeleted = <int>[];


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
      body: BlocBuilder<UserProvider, model.User?>(
        bloc: BlocProvider.of<UserProvider>(context),
        builder: (context, user) {
          return PagedListView.separated(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<model.Post>(
              itemBuilder: (context, item, index) => Visibility(
                visible: !postDeleted.contains(item.id),
                child: Post(
                  post: item,
                  currentUser: user,
                  showArea: true,
                  deleted: () {
                    setState(() {
                      postDeleted.add(item.id);
                    });
                  },
                ),
              ),
            ),
            separatorBuilder: (context, index) {
              return Visibility(
                  visible: !postDeleted
                      .contains(_pagingController.itemList?[index].id),
                  child: const Divider(
                    thickness: 0.3,
                  ));
            },
          );
        }
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
