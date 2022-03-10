abstract class AuthRepository {
  Future<void> login();

  Future<void> registration();

  Future<void> logOut();
}
