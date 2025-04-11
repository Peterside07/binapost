import 'package:binapost/features/post/widget/post_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/post_view_model.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostViewModel>().loadPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PostViewModel>();
    final posts = vm.posts;
    final loading = vm.isLoading;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          if (loading)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator.adaptive()),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final post = posts[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: PostCard(post: post),
                    );
                  },
                  childCount: posts.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}