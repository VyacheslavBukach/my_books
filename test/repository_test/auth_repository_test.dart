import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_books/data/repositories/firebase_auth_repository_impl.dart';
import 'package:my_books/domain/repositories/auth_repository.dart';

class UserMock extends Mock implements User {}

class UserCredentialMock extends Mock implements UserCredential {}

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

// @GenerateMocks([User, UserCredential])
void main() {
  late FirebaseAuthMock firebaseAuth;
  late AuthRepository authRepository;
  late UserMock user;
  late UserCredentialMock userCredential;

  setUp(() {
    firebaseAuth = FirebaseAuthMock();
    authRepository = FirebaseAuthRepositoryImpl(firebaseAuth: firebaseAuth);
    user = UserMock();
    userCredential = UserCredentialMock();
  });

  test('sign in test', () async {
    when(
      firebaseAuth.signInWithEmailAndPassword(
          email: 'email', password: 'password'),
    ).thenAnswer((_) => Future.value(userCredential));
    when(() => userCredential.user).thenReturn(() => user);

    await authRepository.signIn('email', 'password');

    final userEmail = authRepository.currentUser?.email;
    print(userEmail);

    expect(userEmail, 'email');
  });
}
