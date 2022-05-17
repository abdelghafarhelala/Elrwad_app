import 'package:alrwad/appCubit/app_cubit.dart';
import 'package:alrwad/components/components.dart';
import 'package:alrwad/modules/categories/categories.dart';
import 'package:alrwad/modules/layoutScreen/layoutScreen.dart';

import 'package:alrwad/modules/login/loginCubit/loginCubit.dart';
import 'package:alrwad/modules/login/loginCubit/loginStates.dart';
import 'package:alrwad/modules/mainService/mainServiceScreen.dart';
import 'package:alrwad/modules/register/register.dart';
import 'package:alrwad/network/local/cache_Helper.dart';
import 'package:alrwad/shared/const.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.model?.result == true) {
              CacheHelper.saveData(
                      key: "token", value: state.model?.success!.token)
                  .then((value) {
                token = state.model?.success?.token;
                navigateAndFinish(context, LayoutScreen());
                AppCubit.get(context).getUserData();
                showToast(
                    text: 'تم تسجيل الدخول بنجاح', state: ToastStates.success);
                // print(state.model?.data!.name);
              });
            } else {
              showToast(
                  text: state.model?.error_message, state: ToastStates.error);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('تسجيل الدخول'),
              centerTitle: true,
            ),
            body: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/logo.jpeg',
                            height: 170,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // Text('تسجيل الدخول ',
                          //     style: Theme.of(context).textTheme.bodyText1),
                          const SizedBox(
                            height: 30,
                          ),
                          defaultTextField(
                              lable: 'رقم الهاتف',
                              controller: phoneController,
                              prefix: Icons.person,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'يجب ان تدخل رقم الهاتف';
                                }
                              },
                              context: context,
                              type: TextInputType.phone),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultTextField(
                              controller: passwordController,
                              lable: 'كلمه السر',
                              prefix: Icons.lock,
                              suffix: LoginCubit.get(context).suffix,
                              suffixPressed: () {
                                LoginCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              isSecure: LoginCubit.get(context).isPass,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'يجب ان تدخل كلمه السر';
                                }
                              },
                              context: context,
                              type: TextInputType.visiblePassword),
                          const SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) => defaultButton(
                                onPress: () {
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.get(context).userLogin(
                                        phone: phoneController.text,
                                        password: passwordController.text,
                                        context: context);
                                  } else {}
                                },
                                text: 'تسجيل الدخول'),
                            fallback: (context) =>
                                const CircularProgressIndicator(),
                          ),
                          // Container(
                          //   width: double.infinity,
                          //   height: 50,
                          //   child: OutlinedButton(
                          //       onPressed: () {}, child: const Text('data')),
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'ليس لديك حساب',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              TextButton(
                                  onPressed: () {
                                    navigateTo(context, const RegisterScreen());
                                  },
                                  child: const Text(
                                    'حساب جديد',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      // color: Colors.blue,
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
