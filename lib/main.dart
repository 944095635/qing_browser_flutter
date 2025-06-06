import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_links/app_links.dart';
import 'package:get/get.dart';
import 'package:qing/pages/splash/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _initAppLinks();
  runApp(const MyApp());
}

Uri? initialUri;

void _initAppLinks() {
  final appLinks = AppLinks(); // AppLinks is singleton

  // Subscribe to all events (initial link and further)
  final _ = appLinks.uriLinkStream.listen((Uri uri) async {
    initialUri = uri;
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Qing',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: Colors.white,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          fillColor: const Color(0x22FFFFFF),
          filled: true,
          isDense: true,
          hintStyle: TextStyle(
            color: const Color(0xFF888888),
            fontSize: 16,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFF555555),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFF555555),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}
