import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pengajual_judul/app/app.bottomsheets.dart';
import 'package:pengajual_judul/app/app.dialog.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/app.locator.dart';
import 'app/app.router.dart';
import 'app/themes/app_theme.dart';
import 'firebase_options.dart';
import 'services/auth_service.dart';
import 'services/judul_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupLocator();
  setupDialogUi();
  setupBottomsheetUi();

  await locator<AuthService>().syncData();

  Intl.defaultLocale = 'id_ID';
  await initializeDateFormatting();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pengajuan Judul Skripsi',
      theme: appTheme,
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      initialRoute: !locator<AuthService>().isLoggedIn
          ? Routes.signInView
          : Routes.homeView,
    );
  }
}

Future<void> resetLocator() async {
  await locator.reset();

  setupLocator();
  setupDialogUi();
  setupBottomsheetUi();
}
