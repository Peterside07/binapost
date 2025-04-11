import 'package:binapost/features/post/view_model/post_view_model.dart';
import 'package:binapost/features/theme/view_model/view.dart';
import 'package:binapost/features/users/view/user_view.dart';
import 'package:binapost/features/users/view_model/user_view_model.dart';
import 'package:binapost/features/users/widget/show_profile.dart';
import 'package:binapost/features/post/widget/post_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  Future<void> _loadData() async {
    await Future.wait([
      context.read<UserViewModel>().loadUsers(),
      context.read<PostViewModel>().loadPosts(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final userVm = context.watch<UserViewModel>();
    final postVm = context.watch<PostViewModel>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Blinq Explore',
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          IconButton(
            tooltip: 'Toggle Theme',
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              final themeVm = context.read<ThemeViewModel>();
              themeVm.setMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            // User Section
            SizedBox(
              height: 110,
              child: userVm.isLoading
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      scrollDirection: Axis.horizontal,
                      itemCount: userVm.users.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final user = userVm.users[index];
                        return GestureDetector(
                          onTap: () => showUserProfile(context, user),
                          child: Column(
                            children: [
                              UserViewPage(user: user),
                              const SizedBox(height: 6),
                              SizedBox(
                                width: 60,
                                child: Text(
                                  user.username,
                                  style: Theme.of(context).textTheme.labelSmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),

            const Divider(height: 1),

            if (postVm.isLoading)
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Center(child: CircularProgressIndicator.adaptive()),
              )
            else
              ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: postVm.posts.length,
                itemBuilder: (context, index) {
                  final post = postVm.posts[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8),
                    child: PostCard(post: post),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}