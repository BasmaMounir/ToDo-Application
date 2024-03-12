import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/Home/home_screen.dart';
import 'package:to_do_application/Providers/settings-provider.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = 'splash screen';

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return FlutterSplashScreen.fadeIn(
      backgroundImage: provider.isDarkMode()
          ? Image(
              image: AssetImage('assets/images/dark_splash_screen.png'),
            )
          : Image(
              image: AssetImage('assets/images/light_splash_screen.png'),
            ),
      duration: const Duration(seconds: 5),
      onInit: () {
        debugPrint("On Init");
      },
      onEnd: () {
        debugPrint("On End");
      },
      childWidget: const SizedBox(),
      nextScreen: HomeScreen(),
    );
  }
}
