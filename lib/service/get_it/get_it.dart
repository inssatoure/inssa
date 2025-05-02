import 'package:get_it/get_it.dart';
import 'package:quick_resume_creator/repository/user_repository.dart';

class GetItService {
  static final getIt = GetIt.instance;
  static initializeService() {
    getIt.registerSingleton<UserRepository>(UserRepository());
  }
}

T locate<T extends Object>() {
  return GetItService.getIt<T>();
}
