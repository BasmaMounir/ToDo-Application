import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/Home/home_screen.dart';
import 'package:to_do_application/Providers/list_provider.dart';
import 'package:to_do_application/Providers/settings-provider.dart';
import 'package:to_do_application/auth/login/login.dart';
import 'package:to_do_application/auth/register/register_screen.dart';
import 'package:to_do_application/my_theme.dart';
import 'package:to_do_application/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'Your API key',
          appId: 'mobilesdk_app_id',
          messagingSenderId: 'project_number',
          projectId: 'project_id'));
  await FirebaseFirestore.instance.disableNetwork();
  FirebaseFirestore.instance.settings =
      Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  runApp(MultiProvider(
    child: MyApp(),
    providers: [
      ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ChangeNotifierProvider(create: (_) => ListProvider()),
    ],
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale('${provider.language}'),
      title: 'ToDo Application',
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      initialRoute: HomeScreen.routeName,
      routes: {
        SplashScreen.routeName: (_) => const SplashScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
      },
    );
  }
}
