import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ifafu/http/api.dart';
import 'package:ifafu/http/model.dart' as model;
import 'package:ifafu/util/date.dart';
import 'package:ifafu/util/extensions.dart';
import 'package:ifafu/util/snackbar.dart';
import 'package:ifafu/util/toast.dart';
import 'package:ifafu/widget/image_album.dart';

class Post extends StatefulWidget {
  final model.Post post;
  final bool detailMode;
  final model.User? currentUser;
  final bool showArea;

  //删除回调
  final Function? deleted;

  const Post({
    super.key,
    required this.post,
    required this.currentUser,
    this.showArea = false,
    this.deleted,
    this.detailMode = false,
  });

  @override
  State<StatefulWidget> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    if (widget.detailMode) {
      return buildBody();
    } else {
      return GestureDetector(
          onTap: () {
            if (widget.detailMode) {
              return;
            }
            Navigator.of(context).pushNamed('/post/detail', arguments: {
              'id': widget.post.id,
              'post': widget.post,
            });
          },
          child: buildBody()
      );
    }
  }

  Widget buildBody() {
    var comments = widget.post.comments;
    var images = widget.post.images;
    var contactType = widget.post.contactType;
    return  Container(
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 12.0,
        top: 8.0,
        bottom: 4.0,
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getAvatar(widget.post.createBy.avatarUrl),
              const SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.post.createBy.nickname,
                          strutStyle: const StrutStyle(
                            forceStrutHeight: true,
                          ),
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        if (widget.detailMode || widget.showArea) ...[
                          const SizedBox(width: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined,
                                  size: 14.0),
                              Text(widget.post.area),
                            ],
                          ),
                        ]
                      ],
                    ),
                    if (contactType != null &&
                        contactType.isNotEmpty &&
                        widget.post.contact != null)
                      SelectableText(
                        '${widget.post.contactType}: ${widget.post.contact}',
                        autofocus: true,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    if (widget.detailMode)
                      Text(
                        widget.post.content,
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    if (!widget.detailMode)
                      if (widget.post.content.isNotEmpty)
                        LayoutBuilder(
                          builder: (context, constraints) {
                            const maxLines = 5;
                            const textStyle = TextStyle(fontSize: 16.0);
                            var didExceed = didExceedMaxLines(
                              widget.post.content,
                              textStyle,
                              maxLines,
                              constraints.maxWidth,
                            );
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.post.content,
                                  style: textStyle,
                                  maxLines: maxLines,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (didExceed)
                                  const Text(
                                    '点击阅读更多',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.blue,
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                    if (images != null && images.isNotEmpty) ...[
                      const SizedBox(height: 4.0),
                      ImageAlbum(
                        heroTagAddition: hashCode.toString(),
                        oneLineMin: 2,
                        oneLineMax: 3,
                        imageUrls: images,
                      )
                    ],
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          formatTime(widget.post.createTime),
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Color(0xFF8B8989),
                          ),
                        ),
                        //删除按钮
                        if ((widget.currentUser != null &&
                            (widget.currentUser!.id ==
                                widget.post.createBy.id) ||
                            widget.currentUser!.hasPermission('post:del')))
                          GestureDetector(
                            onTap: () {
                              _showDeleteDialog(context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 2),
                              child: Text(
                                '删除',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Color(0xFF4A90E2),
                                ),
                              ),
                            ),
                          ),
                        const Spacer(),
                        if (!widget.detailMode)
                          GestureDetector(
                            onTap: () {
                              // Handle comment click
                            },
                            child: const Icon(Icons.comment, size: 24.0),
                          ),
                        const SizedBox(width: 8),
                        // GestureDetector(
                        //   onTap: () {
                        //     // Handle share click
                        //   },
                        //   child: const Icon(Icons.share_rounded, size: 24.0),
                        // ),
                        // const SizedBox(width: 8),
                      ],
                    ),
                    if (!widget.detailMode &&
                        comments != null &&
                        comments.isNotEmpty) ...[
                      for (var comment in comments.take(4))
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: comment.createBy.nickname,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15.0,
                                ),
                              ),
                              TextSpan(
                                text: '：${comment.content}',
                                style: const TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (comments.length > 4)
                        GestureDetector(
                          child: const Text(
                            '查看更多评论',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Color(0xFF777777),
                            ),
                          ),
                        ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('删除'),
          content: const Text('确定要删除这条帖子吗？'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                Api.instance.deletePost(widget.post.id).then((value) {
                  widget.deleted?.call();
                  Navigator.of(context).pop();
                  SnackBarUtil.show(context, '删除成功');
                }).catchError((err) {
                  if (err is DioException && err.message != null) {
                    ToastUtil.show(err.message!);
                  } else {
                    ToastUtil.show('删除失败');
                  }
                });
              },
              child: const Text('确定'),
            ),
          ],
        );
      },
    );
  }

  bool didExceedMaxLines(
      String text, TextStyle style, int maxLines, double maxWidth) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: maxWidth);
    return textPainter.didExceedMaxLines;
  }

  Widget _getAvatar(String? avatarUrl) {
    if (avatarUrl == null) {
      return const CircleAvatar(
        radius: 22.0,
        backgroundImage: AssetImage('assets/image/defaultAvatar.png'),
      );
    }
    return CircleAvatar(
        radius: 22.0,
        backgroundImage: NetworkImage(avatarUrl.startsWith('/')
            ? 'https://api2.ifafu.cn$avatarUrl'
            : avatarUrl));
  }
}
