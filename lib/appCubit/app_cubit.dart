// ignore_for_file: avoid_print

import 'package:alrwad/components/components.dart';
import 'package:alrwad/models/ContactUsModel/contactUsModel.dart';
import 'package:alrwad/models/aboutUsModel/aboutUsModel.dart';
import 'package:alrwad/models/bookingModel/bookingModel.dart';
import 'package:alrwad/models/categoryModel/categoryModel.dart';
import 'package:alrwad/models/doctorsModel/doctorsModel.dart';
import 'package:alrwad/models/mainServicesModel/mainServicesModel.dart';
import 'package:alrwad/models/profileModel/profileModel.dart';
import 'package:alrwad/models/sliderModel/sliderModel.dart';
import 'package:alrwad/models/socialLinksModel/socialLinksModel.dart';
import 'package:alrwad/models/userModel/userModel.dart';
import 'package:alrwad/modules/bookingScreen/bookingScreen.dart';
import 'package:alrwad/modules/contactUsScreen/contactUs.dart';
import 'package:alrwad/modules/homePage/home.dart';
import 'package:alrwad/modules/login/login.dart';
import 'package:alrwad/modules/mainService/mainServiceScreen.dart';
import 'package:alrwad/network/endpoints.dart';
import 'package:alrwad/network/local/cache_Helper.dart';
import 'package:alrwad/network/remote/dio_helper.dart';
import 'package:alrwad/shared/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  bool isFirst = true;
  List<BottomNavigationBarItem> buttomItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسيه'),
    const BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'الخدمات'),
    const BottomNavigationBarItem(icon: Icon(Icons.phone), label: 'اتصل بنا'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.post_add_outlined), label: 'الحجز'),
  ];
  List<String> titles = [
    'الرئيسيه',
    'الخدمات',
    'اتصل بنا',
    'الحجز',
  ];
  List<Widget> appScreens = [
    const HomeScreen(),
    const MainServicesScreen(),
    const ContactUsScreen(),
    BookingScreen(),
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
  int categoryLength = 0;
  List<String> categoriesNames = [];
  List<String> categoriesNames2 = [];
  List<CategoryData> categoriesData = [];
  CategoryModel? category;
  void getCategoryData() {
    emit(AppGetCategoriesLoadingState());
    DioHelper.getDataWithoutToken(url: categoriesUrl).then((value) {
      category = CategoryModel.fromJson(value.data);
      categoryLength = category!.data!.length;
      category?.data?.forEach((element) {
        categoriesNames.add(element.name!);
        categoriesNames2.add(element.name!);
      });
      category?.data?.forEach((element) {
        categoriesData.add(element);
      });
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
  }) {
    emit(AppPostContactLoadingState());
    DioHelper.postDataWithoutToken(url: contactUsUrl, data: {
      'name': name,
      'phone': phone,
      'email': email,
      'subject': message,
      'message': 'a'
    }).then((value) {
      print(value.data);
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
      profile = ProfileModel.fromJson(value.data);
      print(profile!.data!.name);
      emit(AppGetUserDataSuccessState());
    }).catchError((error) {
      emit(AppGetUserDataErrorState());
      print(error.toString());
    });
  }

//get all doctors
  int doctorsLength = 0;
  DoctorsModel? doctors;
  List doctorsData = [];
  void getDoctorsData(int? categoryId) {
    emit(AppGetDoctorsLoadingState());
    doctorsData = [];
    DioHelper.getDataWithoutToken(url: doctorsUrl).then((value) {
      doctors = DoctorsModel.fromJson(value.data);

      for (int i = 0; i < doctors!.results!.length; i++) {
        if (doctors!.results![i].categoryId == categoryId) {
          doctorsData.add(doctors!.results![i]);
        }
      }
      doctorsLength = doctors!.results!.length;
      print(doctorsData.length);
      emit(AppGetDoctorsSuccessState());
    }).catchError((error) {
      emit(AppGetCategoriesErrorState());
      print(error.toString());
    });
  }

  //get main services
  MainServicesModel? services;
  int serviceLength = 0;
  void getMainServicesData() {
    emit(AppGetMainServicesLoadingState());
    DioHelper.getDataWithoutToken(url: mainServicesUrl).then((value) {
      print(value.data);
      services = MainServicesModel.fromJson(value.data);
      // print(category?.data?[0].name);
      serviceLength = services!.data!.length;
      emit(AppGetMainServicesSuccessState());
    }).catchError((error) {
      emit(AppGetMainServicesErrorState());
      print(error.toString());
    });
  }

  //make booking
  BookingModel? book;
  void makeBooking({
    required int categoryId,
    required int doctorId,
    required String date,
    required String workKind,
    String companyName = '',
    required String cardNumber,
  }) {
    emit(AppPostBookingLoadingState());
    DioHelper.postData(url: bookingUrl, token: token, data: {
      'category_id': categoryId,
      'doctor_id': doctorId,
      'date': date,
      'work_kind': workKind,
      'company_name': companyName,
      'carneh_num': cardNumber,
    }).then((value) {
      book = BookingModel.fromJson(value.data);
      emit(AppPostBookingSuccessState(book!));
      print(book!.success);
    }).catchError((error) {
      emit(AppPostBookingErrorState());
      print(error.toString());
    });
  }

  SocialLinksModel? social;
  int socialLength = 0;
  void getSocialData() {
    emit(AppGetSocialDataLoadingState());
    DioHelper.getDataWithoutToken(url: socialUrl).then((value) {
      print(value.data);
      social = SocialLinksModel.fromJson(value.data);
      // print(category?.data?[0].name);
      socialLength = social!.socialMedia!.length;
      emit(AppGetSocialDataSuccessState());
    }).catchError((error) {
      emit(AppGetSocialDataErrorState());
      print(error.toString());
    });
  }

  void logOut(context) {
    CacheHelper.removeData(key: 'token').then((value) {
      if (value) {
        profile = null;
        navigateAndFinish(context, const LoginScreen());
        emit(AppLogoutSuccessState());
      }
    });
  }

//get slider data
  SliderModel? slider;
  int sliderLength = 0;
  void getSliderData() {
    emit(AppGetSliderDataLoadingState());
    DioHelper.getDataWithoutToken(url: sliderUrl).then((value) {
      print(value.data);
      slider = SliderModel.fromJson(value.data);
      // print(category?.data?[0].name);
      sliderLength = slider!.data!.length;
      emit(AppGetSliderDataSuccessState());
    }).catchError((error) {
      emit(AppGetSliderDataErrorState());
      print(error.toString());
    });
  }

  //get about us data
  AboutUsModel? about;

  void getAboutData() {
    emit(AppGetAboutUsDataLoadingState());
    DioHelper.getDataWithoutToken(url: aboutUsUrl).then((value) {
      print(value.data);
      about = AboutUsModel.fromJson(value.data);
      // print(category?.data?[0].name);
      emit(AppGetAboutUsDataSuccessState());
    }).catchError((error) {
      emit(AppGetAboutUsDataErrorState());
      print(error.toString());
    });
  }

  void doctorDropDownList(doctor, val) {
    // ignore: prefer_conditional_assignment
    if (doctor == null) {
      doctor = val;
      emit(AppDoctorDropListSuccessState());
    }
  }

  String categoryDropDownList(categoryName, val) {
    // ignore: prefer_conditional_assignment
    if (categoryName == null) {
      categoryName = val;
      emit(AppCategoryDropListSuccessState());
    }
    return categoryName;
  }
}
