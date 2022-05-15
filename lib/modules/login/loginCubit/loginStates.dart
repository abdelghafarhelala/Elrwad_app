import 'package:alrwad/models/userModel/userModel.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginPasswordShown extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final UserModel? model;

  LoginSuccessState(this.model);
}

class LoginErrorState extends LoginStates {}
