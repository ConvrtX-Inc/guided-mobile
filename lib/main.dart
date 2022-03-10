// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/routes/route_generator.dart';
import 'package:intl/date_symbol_data_local.dart';

String _defaultHome = '/login';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  runApp(const MyApp());

  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

/// My App Root
class MyApp extends StatelessWidget {
  /// Constructor
  const MyApp({Key? key}) : super(key: key);

  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Splash(),
          );
        } else {
          return ScreenUtilInit(
            builder: () => KeyboardDismissOnTap(
              child: GetMaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  fontFamily: 'Gilroy',
                  backgroundColor: HexColor('#E5E5E5'),
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  textTheme: const TextTheme(
                    bodyText1: TextStyle(
                      color: Colors.black,
                    ),
                    bodyText2: TextStyle(
                      color: Colors.black,
                    ),
                  ).apply(
                      // fontFamily: 'Lora',
                      // bodyColor: Colors.white,
                      // displayColor: Colors.white,
                      ),
                ),
                initialRoute: _defaultHome,
                onGenerateRoute: RouteGenerator.generateRoute,
                localizationsDelegates: const [
                  FormBuilderLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en', ''),
                  Locale('es', ''),
                  Locale('fa', ''),
                  Locale('fr', ''),
                  Locale('ja', ''),
                  Locale('pt', ''),
                  Locale('sk', ''),
                  Locale('pl', ''),
                  // Locale('en_ISO', ''),
                  // Locale('af', ''),
                  // Locale('am', ''),
                  // Locale('am', ''),
                  // Locale('ar_DZ', ''),
                  // Locale('ar_DZ', ''),
                  // Locale('az', ''),
                  // Locale('be', ''),
                  // Locale('bg', ''),
                  // Locale('bn', ''),
                  // Locale('bn', ''),
                  // Locale('bs', ''),
                  // Locale('ca', ''),
                  // Locale('chr', ''),
                  // Locale('cs', ''),
                  // Locale('cy', ''),
                  // Locale('da', ''),
                  // Locale('de', ''),
                  // Locale('de_AT', ''),
                  // Locale('de_AT', ''),
                  // Locale('el', ''),
                  // Locale('en', ''),
                  // Locale('en_AU', ''),
                  // Locale('en_CA', ''),
                  // Locale('en_GB', ''),
                  // Locale('en_IE', ''),
                  // Locale('en_IN', ''),
                  // Locale('en_MY', ''),
                  // Locale('en_SG', ''),
                  // Locale('en_US', ''),
                  // Locale('en_ZA', ''),
                  // Locale('es', ''),
                  // Locale('es_419', ''),
                  // Locale('es_ES', ''),
                  // Locale('es_MX', ''),
                  // Locale('es_US', ''),
                  // Locale('et', ''),
                  // Locale('eu', ''),
                  // Locale('fa', ''),
                  // Locale('fi', ''),
                  // Locale('fil', ''),
                  // Locale('fr', ''),
                  // Locale('fr_CA', ''),
                  // Locale('fr_CH', ''),
                  // Locale('ga', ''),
                  // Locale('gl', ''),
                  // Locale('gsw', ''),
                  // Locale('gu', ''),
                  // Locale('haw', ''),
                  // Locale('he', ''),
                  // Locale('hi', ''),
                  // Locale('hr', ''),
                  // Locale('hu', ''),
                  // Locale('hy', ''),
                  // Locale('id', ''),
                  // Locale('in', ''),
                  // Locale('is', ''),
                  // Locale('it', ''),
                  // Locale('it_CH', ''),
                  // Locale('iw', ''),
                  // Locale('ja', ''),
                  // Locale('ka', ''),
                  // Locale('kk', ''),
                  // Locale('km', ''),
                  // Locale('kn', ''),
                  // Locale('ko', ''),
                  // Locale('ky', ''),
                  // Locale('ln', ''),
                  // Locale('lo', ''),
                  // Locale('lt', ''),
                  // Locale('lv', ''),
                  // Locale('mk', ''),
                  // Locale('ml', ''),
                  // Locale('mn', ''),
                  // Locale('mr', ''),
                  // Locale('ms', ''),
                  // Locale('mt', ''),
                  // Locale('my', ''),
                  // Locale('nb', ''),
                  // Locale('ne', ''),
                  // Locale('nl', ''),
                ],
              ),
            ),
            designSize: const Size(375, 812),
          );
        }
      },
    );
  }
}

/// Splash Screen for waiting
class Splash extends StatelessWidget {
  /// Constructor
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(),
    );
  }
}

/// Initialization
class Init {
  Init._();

  /// static final instance
  static final instance = Init._();

  /// async initialization
  Future initialize() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    await Future.delayed(const Duration(seconds: 0));
  }
}
