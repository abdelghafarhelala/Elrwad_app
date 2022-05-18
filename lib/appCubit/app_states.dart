import 'package:alrwad/models/ContactUsModel/contactUsModel.dart';
import 'package:alrwad/models/bookingModel/bookingModel.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeLanguageState extends AppStates {}

class ChangeNavButtomNavState extends AppStates {}

class AppChangeThemState extends AppStates {}

//get user data states
class AppGetUserDataSuccessState extends AppStates {}

class AppGetUserDataErrorState extends AppStates {}

class AppGetUserDataLoadingState extends AppStates {}

//get categories states
class AppGetCategoriesLoadingState extends AppStates {}

class AppGetCategoriesSuccessState extends AppStates {}

class AppGetCategoriesErrorState extends AppStates {}

//get contact states
class AppPostContactSuccessState extends AppStates {
  final contactUsModel model;

  AppPostContactSuccessState(this.model);
}

class AppPostContactErrorState extends AppStates {}

class AppPostContactLoadingState extends AppStates {}

//get doctors states
class AppGetDoctorsSuccessState extends AppStates {}

class AppGetDoctorsErrorState extends AppStates {}

class AppGetDoctorsLoadingState extends AppStates {}

//get main services
class AppGetMainServicesSuccessState extends AppStates {}

class AppGetMainServicesErrorState extends AppStates {}

class AppGetMainServicesLoadingState extends AppStates {}

//post booking
class AppPostBookingSuccessState extends AppStates {
  final BookingModel model;

  AppPostBookingSuccessState(this.model);
}

class AppPostBookingErrorState extends AppStates {}

class AppPostBookingLoadingState extends AppStates {}

//get social data
class AppGetSocialDataSuccessState extends AppStates {}

class AppGetSocialDataErrorState extends AppStates {}

class AppGetSocialDataLoadingState extends AppStates {}

class AppLogoutSuccessState extends AppStates {}

//get slider data
class AppGetSliderDataSuccessState extends AppStates {}

class AppGetSliderDataErrorState extends AppStates {}

class AppGetSliderDataLoadingState extends AppStates {}

//get about us data
class AppGetAboutUsDataSuccessState extends AppStates {}

class AppGetAboutUsDataErrorState extends AppStates {}

class AppGetAboutUsDataLoadingState extends AppStates {}
