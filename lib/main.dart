import 'package:google_fonts/google_fonts.dart';
import 'package:sapid_labs_core/app/get_it.dart';
import 'package:sapid_labs_core/app/router.dart';
import 'package:sapid_labs_core/app/services.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:sapid_labs_core/app/theme.dart';
import 'package:get_it/get_it.dart';
import 'package:sapid_labs_core/features/settings/services/settings_service.dart';
import 'package:signals/signals_flutter.dart';
import 'package:sapid_labs_core/features/shared/utils/navigation_observers.dart';

Future<void> main() async {
  // Comment to activate Signals logging
  SignalsObserver.instance = null;

  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  GetIt.instance.registerSingleton(AppRouter());

  await setup();

  runApp(const MainApp());
}

Future<void> setup() async {
  await configureDependencies();
}

String? fontFamily = GoogleFonts.quicksand().fontFamily;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: FlexThemeData.light(
          fontFamily: fontFamily,
          scheme: FlexScheme.blueWhale,
          subThemesData: subThemesData,
          pageTransitionsTheme: pageTransitionsTheme,
        ),
        darkTheme: FlexThemeData.dark(
          fontFamily: fontFamily,
          scheme: FlexScheme.blueWhale,
          subThemesData: subThemesData,
          pageTransitionsTheme: pageTransitionsTheme,
        ),
        themeMode: settingsThemeMode.value,
        routerConfig: router.config(
          navigatorObservers: () {
            return [
              NavigationObserver(),
            ];
          },
        ),
      );
    });
  }
}

FlexSubThemesData get subThemesData => FlexSubThemesData(
      defaultRadius: 24,
      inputDecoratorBorderType: FlexInputBorderType.outline,
    );
