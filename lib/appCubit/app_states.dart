import 'package:alrwad/models/ContactUsModel/contactUsModel.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeLanguageState extends AppStates {}

class ChangeNavButtomNavState extends AppStates {}

class AppChangeThemState extends AppStates {}

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

//get doctors states
class AppGetDoctorsSuccessState extends AppStates {}

class AppGetDoctorsErrorState extends AppStates {}

class AppGetDoctorsLoadingState extends AppStates {}

//get main services
class AppGetMainServicesSuccessState extends AppStates {}

class AppGetMainServicesErrorState extends AppStates {}

class AppGetMainServicesLoadingState extends AppStates {}