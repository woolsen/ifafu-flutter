import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:ifafu/http/api.dart';

import 'package:ifafu/http/model.dart' as model;

class MainTab extends StatefulWidget {
  const MainTab({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  var banners = <model.Banner>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
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
                      child: Image.network(
                        banner.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchBanner();
  }

  void fetchBanner() async {
    var data = await Api.instance.getBanners();
    setState(() {
      banners = data;
      if (kDebugMode) {
        print(banners);
      }
    });
  }
}

class TimetableTab extends StatefulWidget {
  const TimetableTab({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CourseTabState();
}

class _CourseTabState extends State<TimetableTab> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('课程表'),
      ),
    );
  }
}

typedef Logout = void Function();

class UserTab extends StatefulWidget {
  final model.User? user;

  final Logout logout;

  const UserTab({Key? key, required this.user, required this.logout})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserTabState();
}

class _UserTabState extends State<UserTab> {
  @override
  Widget build(BuildContext context) {
    var user = widget.user;
    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text('登录'),
        ),
      );
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: NetworkImage(user.avatarUrl),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.user!.nickname,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '发福号: ${widget.user!.id}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 0.5),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('退出登录'),
              onTap: () {
                widget.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
