import 'package:alrwad/models/userModel/userModel.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterPasswordShown extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final UserModel? model;

  RegisterSuccessState(this.model);
}

class RegisterErrorState extends RegisterStates {}
