import 'package:get_it/get_it.dart';
import 'package:my_books/data/repositories/firebase_auth_repository_impl.dart';

final getIt = GetIt.instance;

void initGetIt() {
  getIt.registerLazySingleton(() => FirebaseAuthRepositoryImpl());
}
