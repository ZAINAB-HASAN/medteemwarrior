
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/routes/app_routes.dart';
import 'core/routes/routes_name.dart';
import 'core/theme/app_theme.dart';

import 'bindings/bindings.dart';
import 'data/services/firebase_service.dart';
import 'data/services/notification_services.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  await FirebaseService.init();

  await NotificationService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialBinding: InitialBinding(),
      initialRoute: RoutesName.splash,
      getPages: AppRoutes.appRoutes(),
    );

  }
}