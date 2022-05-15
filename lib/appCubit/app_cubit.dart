import 'package:alrwad/models/ContactUsModel/contactUsModel.dart';
import 'package:alrwad/models/categoryModel/categoryModel.dart';
import 'package:alrwad/models/doctorsModel/doctorsModel.dart';
import 'package:alrwad/models/mainServicesModel/mainServicesModel.dart';
import 'package:alrwad/models/profileModel/profileModel.dart';
import 'package:alrwad/models/userModel/userModel.dart';
import 'package:alrwad/modules/aboutUsScreen/aboutUs.dart';
import 'package:alrwad/modules/contactUsScreen/contactUs.dart';
import 'package:alrwad/modules/homePage/home.dart';
import 'package:alrwad/modules/mainService/mainServiceScreen.dart';

import 'package:alrwad/network/endpoints.dart';
import 'package:alrwad/network/local/cache_Helper.dart';
import 'package:alrwad/network/remote/dio_helper.dart';
import 'package:alrwad/shared/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  List<BottomNavigationBarItem> buttomItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسيه'),
    const BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'الخدمات'),
    const BottomNavigationBarItem(icon: Icon(Icons.phone), label: 'اتصل بنا'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.people_alt), label: 'عن التطبيق'),
  ];
  List<String> titles = [
    'الرئيسيه',
    'الخدمات',
    'اتصل بنا',
    'عن التطبيق',
  ];
  List<Widget> appScreens = [
    const HomeScreen(),
    const MainServicesScreen(),
    const ContactUsScreen(),
    const AboutUsScreen(),
  ];

  int currentIndex = 0;

  void changeAppNav(index) {
    currentIndex = index;
    emit(ChangeNavButtomNavState());
  }

  var isDark = true;
  void changeAppTheme({bool? fromCache}) {
    if (fromCache != null) {
      isDark = fromCache;
      emit(AppChangeThemState());
    } else {
      isDark = !isDark;
      CacheHelper.setBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeThemState());
      });
    }
  }

//get all categories
  CategoryModel? category;
  void getCategoryData() {
    emit(AppGetCategoriesLoadingState());
    DioHelper.getData(url: categoriesUrl).then((value) {
      category = CategoryModel.fromJson(value.data);
      print(category?.data?[0].name);
      emit(AppGetCategoriesSuccessState());
    }).catchError((error) {
      emit(AppGetCategoriesErrorState());
      print(error.toString());
    });
  }

//contact us
  contactUsModel? contact;
  void contactUsData({
    required String name,
    required String phone,
    required String email,
    required String message,
    String? details,
  }) {
    DioHelper.postData(url: contactUsUrl, data: {
      'name': name,
      'phone': phone,
      'email': email,
      'subject': details,
      'message': message
    }).then((value) {
      contact = contactUsModel.fromJson(value.data);
      print(contact?.errorMessage);
      emit(AppPostContactSuccessState(contact!));
    }).catchError((error) {
      emit(AppPostContactErrorState());
      print(error.toString());
    });
  }

//get user
  ProfileModel? profile;
  void getUserData() {
    emit(AppGetUserDataLoadingState());
    DioHelper.getData(url: profileUrl, token: token).then((value) {
      print(value.data);
      profile = ProfileModel.fromJson(value.data);
      emit(AppGetUserDataSuccessState());
    }).catchError((error) {
      emit(AppGetUserDataErrorState());
      print(error.toString());
    });
  }

//get all doctors
  DoctorsModel? doctors;
  List doctorsData = [];
  void getDoctorsData(int? categoryId) {
    emit(AppGetDoctorsLoadingState());
    doctorsData = [];
    DioHelper.getData(url: doctorsUrl).then((value) {
      doctors = DoctorsModel.fromJson(value.data);

      for (int i = 0; i < doctors!.results!.length; i++) {
        if (doctors!.results![i].categoryId == categoryId) {
          doctorsData.add(doctors!.results![i]);
        }
      }
      print(doctorsData.length);
      emit(AppGetDoctorsSuccessState());
    }).catchError((error) {
      emit(AppGetCategoriesErrorState());
      print(error.toString());
    });
  }

  //get main services
  MainServicesModel? services;
  void getMainServicesData() {
    emit(AppGetMainServicesLoadingState());
    DioHelper.getData(url: mainServicesUrl).then((value) {
      services = MainServicesModel.fromJson(value.data);
      // print(category?.data?[0].name);
      emit(AppGetMainServicesSuccessState());
    }).catchError((error) {
      emit(AppGetMainServicesErrorState());
      print(error.toString());
    });
  }
}
