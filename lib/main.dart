// ignore_for_file: always_specify_types

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:guided/constants/asset_path.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/routes/route_generator.dart';
import 'package:guided/screens/auths/splashes/splash.dart';
import 'package:guided/screens/main_navigation/home/screens/home_main.dart';
import 'package:guided/screens/message/message_filter_screen.dart';
import 'package:guided/screens/message/message_inbox.dart';
import 'package:guided/utils/services/notification_service.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'firebase/firebase_options.dart';

String _defaultHome = '/';
// String _defaultHome = '/booking_request_package_details';
//test
void main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.bottom, SystemUiOverlay.top]);

  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'].toString();
  Stripe.instance.applySettings();

  await NotificationService().init(); //
  NotificationService().requestIOSPermissions(); //

  // // INITIALIZE FIREBASE
  await Firebase.initializeApp(
      name: 'Guided', options: DefaultFirebaseConfig.platformOptions);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // runApp(const MyApp());



  getToken();

  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Firebase Message: ${message.messageId}');

  RemoteNotification notification = message.notification!;
  AndroidNotification android = message.notification!.android!;

  debugPrint('Android notification ${notification.body} ${android}');
  if (notification != null && android != null) {
    // await NotificationService().showAndroidNotification(
    //     1, 'This is A Test', 'Sample Content');
  }
}

Future<void> getToken() async {
  String? token = await FirebaseMessaging.instance.getToken();

  debugPrint('Firebase Token $token');
}

/// My App Root
class MyApp extends StatelessWidget {
  /// Constructor
  const MyApp({Key? key}) : super(key: key);

  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {


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
