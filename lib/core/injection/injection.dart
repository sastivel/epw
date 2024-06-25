import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/common_imports.dart';

import '../../api/dio.dart';
import '../../repos/authentication/authentication_data_repository.dart';
import '../../repos/authentication/authentication_remote_data_source_impl.dart';
import '../preference/app_preference.dart';

final dl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  dl.registerLazySingleton(() => AppPreferences(sharedPreferences));
  dl.registerFactory(() => DioHelper(
        appPreferences: dl(),
      ));
  dl.registerLazySingleton(() => AuthendicationRemoteDataSourceImpl(
      appPreferences: dl(), dioHelper: dl()));
  dl.registerLazySingleton(
      () => AuthendicationDataRepository(remoteDataSource: dl()));
}
