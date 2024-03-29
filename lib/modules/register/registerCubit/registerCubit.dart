// ignore_for_file: avoid_print
import 'package:alrwad/main.dart';
import 'package:alrwad/models/userModel/userModel.dart';
import 'package:alrwad/modules/register/registerCubit/registerStates.dart';
import 'package:alrwad/network/endpoints.dart';
import 'package:alrwad/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isPass = true;
  IconData suffix = Icons.visibility_outlined;
  void changePasswordVisibility() {
    isPass = !isPass;
    isPass
        ? suffix = Icons.visibility_outlined
        : suffix = Icons.visibility_off_outlined;
    emit(RegisterPasswordShown());
  }

  UserModel? registerModel;
  void userRegister({
    required String email,
    required String phone,
    required String name,
    required String password,
    required String confirmPassword,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postDataWithoutToken(url: registerUrl, data: {
      'email': email,
      'mobile': phone,
      'name': name,
      'password': password,
      'c_password': confirmPassword,
    }).then((value) async {
      registerModel = UserModel.fromJson(value.data);
      // print(registerModel!.data!.name);
      await storage.write(key: 'token', value: registerModel?.success?.token);
      // CacheHelper.saveData(key: 'token', value: registerModel?.success?.token);
      emit(RegisterSuccessState(registerModel));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState());
    });
  }
}
