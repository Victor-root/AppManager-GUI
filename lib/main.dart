import 'dart:io';
import 'package:app_manager/screens/app_manager_page/app_manager_page.dart';
import 'package:app_manager/overlays/intro.dart';
import 'package:app_manager/utils/config.dart';
import 'package:app_manager/utils/localization.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() async {
  final packageInfo = await PackageInfo.fromPlatform();
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigUtils.load();
  await Localization.loadLanguages();
  await Localization.loadLocale(ConfigUtils.currentLanguage ?? 'en');
  appSupportDir = (await getApplicationSupportDirectory()).path;
  iconsDirPath = '$appSupportDir${Platform.pathSeparator}icons${Platform.pathSeparator}'.replaceAll('\\', '/');
  runApp(const MyApp());
  doWhenWindowReady(() {
    const initialSize = Size(900, 650);
    appWindow
      ..minSize = initialSize
      ..size = initialSize
      ..alignment = Alignment.center
      ..title = 'App Manager [${packageInfo.version}]'
      ..show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Manager',
      locale: const Locale('en'),
      supportedLocales: const [Locale('en')],
      theme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
        primaryColor: Colors.blueAccent,
        scaffoldBackgroundColor: Colors.grey[900],
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Colors.grey[850],
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white70, size: 20),
      ),
      initialRoute: ConfigUtils.isFirstLaunch ? '/setup' : '/home',
      routes: {
        '/setup': (context) => IntroductionOverlay(
              onContinue: () {
                Navigator.pushReplacementNamed(context, '/home');
                ConfigUtils.isFirstLaunch = false;
                ConfigUtils.save();
              },
            ),
        '/home': (context) => ValueListenableBuilder<String>(
              valueListenable: Localization.languageNotifier,
              builder: (context, languageCode, child) {
                return const AppManagerPage();
              },
            ),
      },
    );
  }
}
