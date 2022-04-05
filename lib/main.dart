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

// String _defaultHome = '/splash_screen';
String _defaultHome = '/transaction_history';

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
