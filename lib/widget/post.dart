import 'package:flutter/material.dart';
import 'package:ifafu/http/model.dart' as model;

class Post extends StatefulWidget {
  final model.Post post;
  final bool detailMode;

  const Post({
    super.key,
    required this.post,
    this.detailMode = false,
  });

  @override
  State<StatefulWidget> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  widget.post.createBy.avatarUrl,
                ),
                radius: 24.0,
              ),
              const SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post.createBy.nickname,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // if (widget.post['createBy']['title'] != null)
                  //   Container(
                  //     padding: EdgeInsets.symmetric(horizontal: 4.0),
                  //     margin: EdgeInsets.only(top: 4.0),
                  //     decoration: BoxDecoration(
                  //       color: widget.post['createBy']['title']['color'],
                  //       borderRadius: BorderRadius.circular(8.0),
                  //     ),
                  //     child: Text(
                  //       widget.post['createBy']['title']['name'],
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //   ),
                ],
              ),
              const Spacer(),
              if (widget.detailMode)
                Row(
                  children: [
                    Icon(Icons.map, size: 14.0),
                    Text(widget.post.area),
                  ],
                ),
              Spacer(),
              // if (widget.isAdmin)
              //   GestureDetector(
              //     onTap: () {
              //       // Handle admin click
              //     },
              //     child: Icon(Icons.more_vert),
              //   ),
            ],
          ),
          GestureDetector(
            onTap: () {
              if (!widget.detailMode) {
                // Navigate to post detail
                // You can use Navigator.push() to navigate to the detail page
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.post.contactType != null &&
                    widget.post.contact != null)
                  SelectableText(
                    '${widget.post.contactType}: ${widget.post.contact}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                if (widget.detailMode)
                  Text(
                    widget.post.content,
                    style: TextStyle(fontSize: 16.0),
                  ),
                if (!widget.detailMode)
                  // Render truncated text with "Read more" button
                  // You can create a custom widget for this
                  // Example: WoMoreText(text: widget.post['content'])
                  Text(
                    'Truncated text with "Read more" button',
                    style: TextStyle(fontSize: 16.0),
                  ),
                if (widget.post.images.isNotEmpty) const SizedBox(height: 4.0),
                // Render images using WoAlbum widget
                // Example: WoAlbum(urls: widget.post['images'])
              ],
            ),
          ),
          Row(
            children: [
              Text(
                formatTime(widget.post.createTime),
                style: TextStyle(fontSize: 14.0, color: Color(0xFF8B8989)),
              ),
              Spacer(),
              if (!widget.detailMode)
                GestureDetector(
                  onTap: () {
                    // Handle comment click
                  },
                  child: Icon(Icons.message, size: 24.0),
                ),
              if (widget.detailMode)
                GestureDetector(
                  onTap: () {
                    // Handle share click
                  },
                  child: Icon(Icons.share, size: 24.0),
                ),
            ],
          ),
          if (!widget.detailMode && widget.post.comments.isNotEmpty)
            Column(
              children: [
                for (var comment in widget.post.comments.take(4).toList())
                  Container(
                    margin: EdgeInsets.only(top: 4.0),
                    child: Row(
                      children: [
                        Text(
                          comment.createBy.nickname,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('：${comment.content}'),
                      ],
                    ),
                  ),
                if (widget.post.comments.length > 4)
                  GestureDetector(
                    onTap: () {
                      // Handle "View more comments" click
                      if (!widget.detailMode) {
                        // Navigate to post detail
                        // You can use Navigator.push() to navigate to the detail page
                      }
                    },
                    child: const Text(
                      'View more comments',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFF777777),
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  String formatTime(String? time) {
    // Implement your time formatting logic
    return time ?? '';
  }
}
