import 'package:get_it/get_it.dart';

import 'app_metadata.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => AppMetadata());
}
