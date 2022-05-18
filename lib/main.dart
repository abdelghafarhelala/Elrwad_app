import 'package:alrwad/appCubit/app_cubit.dart';
import 'package:alrwad/appCubit/app_states.dart';
import 'package:alrwad/modules/bookingScreen/bookingScreen.dart';
import 'package:alrwad/modules/categories/categories.dart';
import 'package:alrwad/modules/doctors/doctors.dart';
import 'package:alrwad/modules/homePage/home.dart';
import 'package:alrwad/modules/layoutScreen/layoutScreen.dart';
import 'package:alrwad/modules/login/login.dart';
import 'package:alrwad/modules/mainService/mainServiceScreen.dart';
import 'package:alrwad/modules/on_boarding/onBoardingScreen.dart';
import 'package:alrwad/network/local/cache_Helper.dart';
import 'package:alrwad/network/remote/dio_helper.dart';
import 'package:alrwad/shared/blocObserver/blocObserver.dart';
import 'package:alrwad/shared/const.dart';
import 'package:alrwad/shared/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

SharedPreferences? mySharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await DioHelper.init();
  mySharedPreferences = await SharedPreferences.getInstance();
  bool isDark = false;
  token = CacheHelper.getData(key: 'token');
  bool? onboarding = CacheHelper.getData(key: 'onBoarding');
  if (CacheHelper.getData(key: 'isDark') != null) {
    isDark = CacheHelper.getData(key: 'isDark');
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

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;
  MyApp({required this.isDark, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..changeAppTheme(fromCache: isDark)
        ..getUserData()
        ..getCategoryData()
        ..getMainServicesData()
        ..getSocialData(),
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
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            // home: startWidget,
            home: startWidget,
          );
        },
      ),
    );
  }
}
