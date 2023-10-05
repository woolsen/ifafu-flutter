import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifafu/http/api.dart';
import 'package:ifafu/http/model.dart' as model;
import 'package:ifafu/page/post_create_page.dart';
import 'package:ifafu/provider/user_provider.dart';
import 'package:ifafu/util/dialog.dart';
import 'package:ifafu/util/sp.dart';
import 'package:ifafu/util/toast.dart';
import 'package:ifafu/widget/empty.dart';
import 'package:ifafu/widget/infinite_scroll_pagination.dart';
import 'package:ifafu/widget/post.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MainTab extends StatefulWidget {
  const MainTab({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainTabState();
}

class MainTabState extends State<MainTab> {
  var banners = <model.Banner>[];

  static const _pageSize = 10;

  String? area;

  var postAdded = <model.Post>[];

  var postDeleted = <int>[];

  final PagingController<int, model.Post> _pagingController =
      PagingController(firstPageKey: 0);

  final RefreshController _refreshController = RefreshController();

  final verticalDivider = const ColoredBox(
    color: Colors.grey,
    child: SizedBox(height: 20, width: 1),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProvider, model.User?>(
      bloc: BlocProvider.of<UserProvider>(context),
      builder: (context, user) {
        return Scaffold(
          appBar: _buildAppbar(),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _goToCreatePost(user != null),
            child: const Icon(Icons.add),
          ),
          body: SmartRefresher(
            controller: _refreshController,
            onRefresh: refresh,
            enablePullDown: true,
            // enablePullUp: false,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildTopbar()),
                SliverList(
                  delegate: SliverChildListDelegate.fixed([
                    for (var value in postAdded) ...{
                      Post(
                        post: value,
                        currentUser: user,
                        deleted: () {
                          setState(() {
                            postDeleted.add(value.id);
                          });
                        },
                      ),
                      const Divider(thickness: 0.3),
                    },
                  ]),
                ),
                PagedSliverList.separated(
                  pagingController: _pagingController,
                  builderDelegate: CustomPagedChildBuilder<model.Post>(
                    onTryAgain: () => _pagingController.refresh(),
                    noItemsFoundIndicatorBuilder: (context) {
                      return const Center(
                        child: EmptyIcon(message: '暂无帖子'),
                      );
                    },
                    itemBuilder: (context, item, index) => Visibility(
                      visible: !postDeleted.contains(item.id),
                      child: Post(
                        post: item,
                        currentUser: user,
                        deleted: () {
                          postAdded.removeWhere((element) {
                            return element.id == item.id;
                          });
                          postDeleted.add(item.id);
                          setState(() {});
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
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppbar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(48),
      child: ColoredBox(
        color: const Color(0xFFF5F5F5),
        child: SafeArea(
          child: SizedBox(
            height: 48,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      _showListSelectionDialog(context);
                    },
                    child: Row(
                      children: [
                        const SizedBox(width: 8),
                        const Icon(Icons.location_on),
                        Text(
                          area ?? '点击选择校区',
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'iFAFU',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'DingTalk',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopbar() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.4,
            ),
            items: banners.map((banner) {
              return Builder(
                builder: (context) => Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(
                    imageUrl: banner.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        _buildToolButtonLayout(),
      ],
    );
  }

  Widget _buildToolButtonLayout() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.all(Radius.circular(8)),
      // ),
      // clipBehavior: Clip.hardEdge,
      child: ColoredBox(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(children: [
            _buildToolButton(
              '词条问答',
              'assets/image/qa.png',
              routerName: '/qa',
            ),
            _buildToolButton(
              '专业课表',
              'assets/image/timetable.png',
              routerName: '/timetable/major/select',
            ),
            const Expanded(child: SizedBox.shrink()),
            const Expanded(child: SizedBox.shrink()),
          ]),
        ),
      ),
    );
  }

  Widget _buildToolButton(
    String text,
    String image, {
    required String routerName,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, routerName);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          child: Column(
            children: [
              Image(
                width: 36,
                image: AssetImage(image),
              ),
              const SizedBox(height: 4),
              Text(
                text,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    area = SPUtil.getString('AREA');
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _goToCreatePost(bool isLogon) async {
    if (!isLogon) {
      ToastUtil.show('请先登录');
      return;
    }
    final post = await Navigator.of(context).push(MaterialPageRoute<model.Post>(
      builder: (context) => const PostCreatePage(),
    ));
    if (post != null && post.area == area) {
      postAdded.add(post);
      setState(() {});
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      if (pageKey == 0) {
        postAdded.clear();
        postDeleted.clear();
        await fetchBanner();
      }
      if (area == null) {
        _showListSelectionDialog(context);
        _pagingController.itemList = [];
      } else {
        final newItems = await Api.instance.getPosts(pageKey, _pageSize, area!);
        final isLastPage = newItems.length < _pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(newItems, nextPageKey);
        }
      }
      if (_refreshController.isRefresh) {
        _refreshController.refreshCompleted();
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> fetchBanner() async {
    var data = await Api.instance.getBanners(area);
    setState(() {
      banners = data;
    });
  }

  Future<void> _showListSelectionDialog(BuildContext context) async {
    final areas = ['金山校区', '旗山校区', '安溪校区'];
    final selectedValue = await showSimpleDialog(
      context,
      areas,
      barrierDismissible: false,
      title: '选择校区',
    );
    if (selectedValue != null && selectedValue != area) {
      area = selectedValue;
      setState(() {});
      SPUtil.setString('AREA', selectedValue);
      refresh();
    }
  }

  refresh() async {
    postAdded.clear();
    postDeleted.clear();
    _pagingController.refresh();
    _refreshController.requestRefresh();
  }
}
