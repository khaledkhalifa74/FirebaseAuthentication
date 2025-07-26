import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_features/features/Authentication/presentation/views/login_view.dart';
import 'package:firebase_features/firebase_options.dart';
import 'package:firebase_features/simple_bloc_observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_features/core/utils/globals.dart' as globals;
import 'package:firebase_features/core/utils/colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(
    const RestartWidget(
      child: MyApp(),
    ),
  );
}

// restart widget
class RestartWidget extends StatefulWidget {
  const RestartWidget({super.key, required this.child});
  final Widget child;
  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<RestartWidgetState>()?.restartApp();
  }

  @override
  RestartWidgetState createState() => RestartWidgetState();
}
class RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();
  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedPreferences sharedPrefs;
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
    });
  }
  @override
  Widget build(BuildContext context) {
    try {
      if (sharedPrefs.getString('locale') == null) {
        sharedPrefs.setString('locale', globals.appLang);
      }
      globals.appLang = ((sharedPrefs.getString('locale') != null &&
          sharedPrefs.getString('locale') != null)
          ? sharedPrefs.getString('locale')
          : globals.appLang)!;

    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child){
        return MaterialApp(
          title: 'Firebase Features',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('ar'), // Arabic
          ],
          locale: Locale(globals.appLang),
          theme: ThemeData(
            colorScheme: const ColorScheme.light(primary: kPrimaryColor),
            useMaterial3: true,
            textTheme: GoogleFonts.ibmPlexSansArabicTextTheme(),
            primaryColor: kPrimaryColor,
          ),
          navigatorKey: globals.navigatorKey,
          debugShowCheckedModeBanner: false,
          initialRoute: LoginView.id,
          routes: {
            LoginView.id: (context) => const LoginView(),
          },
        );
      }
    );
  }
}
