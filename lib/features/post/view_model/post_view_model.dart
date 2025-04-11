import 'package:flutter/material.dart';
import '../../../core/models/post_model.dart';
import '../../../core/repository/post_repository.dart';

class PostViewModel extends ChangeNotifier {
  final PostRepository _postRepository;
  bool _isLoading = false;
  String? _errorMessage;
  List<PostModel> _posts = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<PostModel> get posts => _posts;

  PostViewModel(this._postRepository);

  Future<void> loadPosts() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _posts = await _postRepository.fetchPosts();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
