import 'package:wall_app/core/network/api.dart';

import '../di/service_locator.dart';

Future<void> initApp() async {
  await sl.allReady();

  sl.registerLazySingleton<API>(() => API());

}
