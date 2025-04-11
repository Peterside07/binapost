import 'package:flutter/material.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/repository/user_repository.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  bool _isLoading = false;
  String? _errorMessage;
  List<UserModel> _users = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<UserModel> get users => _users;

  UserViewModel(this._userRepository);

  Future<void> loadUsers() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _users = await _userRepository.fetchUsers();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
