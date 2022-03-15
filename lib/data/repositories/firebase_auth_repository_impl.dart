import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_books/domain/repositories/auth_repository.dart';

const _kUserNotFound = 'user-not-found';
const _kWrongPassword = 'wrong-password';
const _kWeakPassword = 'weak-password';
const _kEmailAlreadyInUse = 'email-already-in-use';

class FirebaseAuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == _kUserNotFound) {
        throw Exception('No user found for that email.');
      } else if (e.code == _kWrongPassword) {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  @override
  Future<void> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == _kWeakPassword) {
        throw Exception('The password provided is too weak.');
      } else if (e.code == _kEmailAlreadyInUse) {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Stream<User?> authStateChanges() => FirebaseAuth.instance.authStateChanges();

  @override
  User? getCurrentUser() => _firebaseAuth.currentUser;
}
