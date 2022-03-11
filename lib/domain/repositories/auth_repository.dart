abstract class AuthRepository {
  Future<void> login(String email, String password);

  Future<void> registration(String email, String password);

  Future<void> logOut();
}
