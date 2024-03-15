import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/Home/TasksList/edit_task.dart';
import 'package:to_do_application/Home/home_screen.dart';
import 'package:to_do_application/Providers/authProviders.dart';
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
          apiKey: 'AIzaSyDi5kVu6TdZXIK57kNBakMdCjxZx_ucdBk',
          appId: 'todo-app-889a8',
          messagingSenderId: 'project_number',
          projectId: 'todo-app-889a8'));

  // await FirebaseFirestore.instance.disableNetwork();
  // FirebaseFirestore.instance.settings =
  //     Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  runApp(MultiProvider(
    child: MyApp(),
    providers: [
      ChangeNotifierProvider(
          create: (_) => SettingsProvider()..loadSettingData()),
      ChangeNotifierProvider(create: (_) => ListProvider()),
      ChangeNotifierProvider(create: (_) => AuthProviders()),
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
      locale: Locale('${provider.appLanguage}'),
      title: 'ToDo Application',
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        EditTask.routeName: (context) => EditTask(),
      },
    );
  }
}
