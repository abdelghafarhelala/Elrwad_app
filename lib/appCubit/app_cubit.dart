import 'package:alrwad/models/ContactUsModel/contactUsModel.dart';
import 'package:alrwad/models/bookingModel/bookingModel.dart';
import 'package:alrwad/models/categoryModel/categoryModel.dart';
import 'package:alrwad/models/doctorsModel/doctorsModel.dart';
import 'package:alrwad/models/mainServicesModel/mainServicesModel.dart';
import 'package:alrwad/models/profileModel/profileModel.dart';
import 'package:alrwad/modules/bookingScreen/bookingScreen.dart';
import 'package:alrwad/modules/contactUsScreen/contactUs.dart';
import 'package:alrwad/modules/homePage/home.dart';
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
  CategoryModel? category;
  void getCategoryData() {
    emit(AppGetCategoriesLoadingState());
    DioHelper.getDataWithoutToken(url: categoriesUrl).then((value) {
      category = CategoryModel.fromJson(value.data);
      categoryLength = category!.data!.length;
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
  // void userLogin(
  //     {required String phone, required String password, required var context}) {
  //   emit(LoginLoadingState());
  //   DioHelper.postDataWithoutToken(url: loginUrl, data: {
  //     'mobile': phone,
  //     'password': password,
  //     'onesignal_id': '1',
  //   }).then((value) {
  //     loginModel = UserModel.fromJson(value.data);
  //     CacheHelper.saveData(key: 'token', value: loginModel!.success!.token);
  //     emit(LoginSuccessState(loginModel));
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(LoginErrorState());
  //   });
  // }

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
}
