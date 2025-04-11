import 'package:binapost/core/config/theme.dart';
import 'package:binapost/core/repository/post_repository.dart';
import 'package:binapost/core/repository/user_repository.dart';
import 'package:binapost/features/home_page.dart';
import 'package:binapost/features/post/view_model/post_view_model.dart';
import 'package:binapost/features/theme/view_model/view.dart';
import 'package:binapost/features/users/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostViewModel(PostRepository())),
        ChangeNotifierProvider(create: (_) => UserViewModel(UserRepository())),
        ChangeNotifierProvider(
          create: (_) => ThemeViewModel(),
        ),
      ],
      child: Consumer<ThemeViewModel>(
        builder: (_, themeVm, __) {
          return MaterialApp(
            title: 'BlinqPost',
            theme: theme,
            darkTheme: ThemeData.dark(),
            themeMode: themeVm.mode,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
