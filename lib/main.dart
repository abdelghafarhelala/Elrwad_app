import 'package:alrwad/appCubit/app_cubit.dart';
import 'package:alrwad/appCubit/app_states.dart';
import 'package:alrwad/modules/layoutScreen/layoutScreen.dart';
import 'package:alrwad/modules/on_boarding/onBoardingScreen.dart';
import 'package:alrwad/network/local/cache_Helper.dart';
import 'package:alrwad/network/remote/dio_helper.dart';
import 'package:alrwad/shared/blocObserver/blocObserver.dart';
import 'package:alrwad/shared/const.dart';
import 'package:alrwad/shared/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// import 'package:flutter_native_splash/flutter_native_splash.dart';
const storage = FlutterSecureStorage();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences.setMockInitialValues({});

  // await CacheHelper.init();
  await DioHelper.init();
  Admob.initialize();
  // await MobileAds.instance.initialize();
  // mySharedPreferences = await SharedPreferences.getInstance();
  bool isDark = false;
  token = await storage.read(key: 'token');
  // token = CacheHelper.getData(key: 'token');
  bool? onboarding = await storage.containsKey(key: 'onBoarding');
  // CacheHelper.getData(key: 'onBoarding');
  if (await storage.read(key: 'isDark') != null) {
    isDark = await storage.containsKey(key: 'isDark');
  } else {
    isDark = isDark;
  }

  Widget? widget;
  if (onboarding != null) {
    if (token != null) {
      widget = LayoutScreen();
    } else {
      widget = LayoutScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  BlocOverrides.runZoned(
    () {
      // Use cubits...
      runApp(MyApp(
        isDark: isDark,
        startWidget: widget!,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}
// test id -->ca-app-pub-3940256099942544~1458002511
// app id ---> ca-app-pub-7398921363049960~7158884224
// banner ID ---->ca-app-pub-7398921363049960/6209614693

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;
  const MyApp({Key? key, required this.isDark, required this.startWidget})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..changeAppTheme(fromCache: isDark)
        ..getUserData()
        ..getCategoryData()
        ..getMainServicesData()
        ..getSocialData()
        ..getAboutData()
        ..getSliderData(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('ar', ''), // arabic, no country code
              ],
              debugShowCheckedModeBanner: false,
              locale: const Locale('ar'),
              title: 'home',
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              // home: startWidget,
              home: startWidget,
              builder: (context, child) {
                return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: child!);
              });
        },
      ),
    );
  }
}
