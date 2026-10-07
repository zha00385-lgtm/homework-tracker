import 'package:firebase_auth/firebase_auth.dart';

import '../models/auth_model.dart';

class AuthPresenter {
  final AuthModel _model = AuthModel();

  Future<String?> login(String email, String password) async {
    return await _model.login(email, password);
  }

  Future<String?> signUp(String email, String password) async {
    return await _model.signUp(email, password);
  }

  Future<void> logout() async {
    await _model.logout();
  }

  Stream<User?> authStateChanges() => FirebaseAuth.instance.authStateChanges();

  String? getCurrentUserEmail() => FirebaseAuth.instance.currentUser?.email;
}