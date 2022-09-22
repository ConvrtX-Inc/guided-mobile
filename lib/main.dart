// ignore_for_file: always_specify_types

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/routes/route_generator.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'firebase/firebase_options.dart';

String _defaultHome = '/';
//test
void main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);

  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'].toString();
  await Stripe.instance.applySettings();

  await Firebase.initializeApp(
      name: 'Guided', options: DefaultFirebaseConfig.platformOptions);
  // runApp(const MyApp());

  await initializeDateFormatting().then((_) => runApp(const MyApp()));
}

/// My App Root
class MyApp extends StatelessWidget {
  /// Constructor
  const MyApp({Key? key}) : super(key: key);

  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (c, child) => KeyboardDismissOnTap(
        child: child!,
      ),
      designSize: const Size(375, 812),
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
    );
  }
}
