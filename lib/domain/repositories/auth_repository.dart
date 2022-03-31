import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  FirebaseAuth get firebaseAuth;

  User? get currentUser;

  Future<void> signIn(String email, String password);

  Future<void> signUp(String email, String password);

  Future<void> signOut();

  Stream<User?> authStateChanges();
}
