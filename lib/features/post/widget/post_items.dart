
import 'package:binapost/core/config/colors.dart';
import 'package:flutter/material.dart';
import '../../../core/models/post_model.dart';
import 'video_player_widget.dart';

class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    Widget mediaWidget;

    // Text post (no media)
    if (post.noMedia) {
      mediaWidget = Container(
        height: 300,
        width: double.infinity,
        color: appColor.lightGray,
        child: const Center(child: Icon(Icons.text_fields, size: 48)),
      );
    }
    // Video post
    else if (post.video) {
      mediaWidget = SizedBox(
        height: 300,
        width: double.infinity,
        child:
            VideoPlayerWidget(videoUrl: post.link, thumbnail: post.thumbnail),
      );
    }
    // Image post
    else {
      mediaWidget = Image.network(
        post.link,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 220,
      );
    }

    return Hero(
      tag: 'post_${post.id}',
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mediaWidget,
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                post.description ?? '',
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text('- by ${post.username}',
                  style: Theme.of(context).textTheme.bodySmall),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
