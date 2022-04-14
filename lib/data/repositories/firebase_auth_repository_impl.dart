import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_books/domain/repositories/auth_repository.dart';

const _kInvalidEmail = 'invalid-email';
const _kUserDisabled = 'user-disabled';
const _kUserNotFound = 'user-not-found';
const _kWrongPassword = 'wrong-password';

const _kWeakPassword = 'weak-password';
const _kOperationNotAllowed = 'operation-not-allowed';
const _kEmailAlreadyInUse = 'email-already-in-use';

class FirebaseAuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  FirebaseAuth get firebaseAuth => _firebaseAuth;

  @override
  User? get currentUser => _firebaseAuth.currentUser;

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
      } else if (e.code == _kInvalidEmail) {
        throw Exception('Email address is not valid.');
      } else if (e.code == _kUserDisabled) {
        throw Exception('User disabled.');
      } else {
        throw Exception(e.message);
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
      } else if (e.code == _kInvalidEmail) {
        throw Exception('Email address is not valid.');
      } else if (e.code == _kOperationNotAllowed) {
        throw Exception('Email/password accounts are not enabled.');
      } else {
        throw Exception(e.message);
      }
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
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();
}
