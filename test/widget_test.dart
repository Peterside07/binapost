import 'package:binapost/features/users/view_model/user_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:binapost/core/models/user_model.dart';
import 'package:binapost/core/models/post_model.dart';
import 'package:binapost/core/repository/user_repository.dart';
import 'package:binapost/core/repository/post_repository.dart';
import 'package:binapost/features/post/view_model/post_view_model.dart';

import 'widget_test.mocks.dart';

@GenerateMocks([UserRepository, PostRepository])
void main() {
  group('PostViewModel Tests', () {
    late MockPostRepository mockPostRepo;
    late PostViewModel postViewModel;

    final samplePost = PostModel(
      id: '1',
      userId: 'user1',
      username: 'User One',
      description: 'This is a test post',
      link: 'https://example.com/image.jpg',
      thumbnail: 'https://example.com/thumbnail.jpg',
      noMedia: false,
      video: false,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );

    setUp(() {
      mockPostRepo = MockPostRepository();
      postViewModel = PostViewModel(mockPostRepo);
    });

    test('loadPosts fetches posts successfully', () async {
      when(mockPostRepo.fetchPosts()).thenAnswer((_) async => [samplePost]);

      await postViewModel.loadPosts();

      expect(postViewModel.posts.length, 1);
      expect(postViewModel.posts.first.id, samplePost.id);
      expect(postViewModel.isLoading, false);
      expect(postViewModel.errorMessage, isNull);
      verify(mockPostRepo.fetchPosts()).called(1);
    });

    test('loadPosts handles error correctly', () async {
      const errorMessage = 'Failed to fetch posts';
      when(mockPostRepo.fetchPosts()).thenThrow(Exception(errorMessage));

      await postViewModel.loadPosts();

      expect(postViewModel.posts, isEmpty);
      expect(postViewModel.isLoading, false);
      expect(postViewModel.errorMessage, contains(errorMessage));
      verify(mockPostRepo.fetchPosts()).called(1);
    });

    test('loadPosts manages loading state correctly', () async {
      when(mockPostRepo.fetchPosts()).thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 100));
        return [samplePost];
      });

      expect(postViewModel.isLoading, false);
      final future = postViewModel.loadPosts();
      expect(postViewModel.isLoading, true);

      await future;

      expect(postViewModel.isLoading, false);
      expect(postViewModel.posts.length, 1);
      expect(postViewModel.errorMessage, isNull);
    });
  });

  group('UserViewModel Tests', () {
    late MockUserRepository mockUserRepo;
    late UserViewModel userViewModel;

    final sampleUser = UserModel(
      userId: 'user1',
      username: 'johndoe',
      name: 'John Doe',
      bio: 'Flutter enthusiast',
      photo: 'https://example.com/avatar.jpg',
    );

    setUp(() {
      mockUserRepo = MockUserRepository();
      userViewModel = UserViewModel(mockUserRepo);
    });

    test('loadUsers fetches users successfully', () async {
      when(mockUserRepo.fetchUsers()).thenAnswer((_) async => [sampleUser]);

      await userViewModel.loadUsers();

      expect(userViewModel.users.length, 1);
      expect(userViewModel.users.first.username, sampleUser.username);
      expect(userViewModel.isLoading, false);
      expect(userViewModel.errorMessage, isNull);
      verify(mockUserRepo.fetchUsers()).called(1);
    });

    test('loadUsers handles error correctly', () async {
      const errorMessage = 'Failed to fetch users';
      when(mockUserRepo.fetchUsers()).thenThrow(Exception(errorMessage));

      await userViewModel.loadUsers();

      expect(userViewModel.users, isEmpty);
      expect(userViewModel.isLoading, false);
      expect(userViewModel.errorMessage, contains(errorMessage));
      verify(mockUserRepo.fetchUsers()).called(1);
    });

    test('loadUsers loading state is handled correctly', () async {
      when(mockUserRepo.fetchUsers()).thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 100));
        return [sampleUser];
      });

      expect(userViewModel.isLoading, false);
      final future = userViewModel.loadUsers();
      expect(userViewModel.isLoading, true);

      await future;

      expect(userViewModel.isLoading, false);
      expect(userViewModel.users.length, 1);
      expect(userViewModel.errorMessage, isNull);
    });
  });
}
