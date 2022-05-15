import 'package:alrwad/appCubit/app_cubit.dart';
import 'package:alrwad/appCubit/app_states.dart';
import 'package:alrwad/components/components.dart';
import 'package:alrwad/modules/myDrawer/myDrawer.dart';
import 'package:alrwad/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ContactUsDrawerScreen extends StatelessWidget {
  const ContactUsDrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppPostContactSuccessState) {
          showToast(text: state.model.errorMessage, state: ToastStates.success);
        }
      },
      builder: (context, state) {
        var emailController = TextEditingController();
        var nameController = TextEditingController();
        var messageController = TextEditingController();
        var phoneController = TextEditingController();
        var detailsController = TextEditingController();

        var formKey = GlobalKey<FormState>();
        return Scaffold(
          drawer: Drawer(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const MyDrawer(),
                  const MyDrawer().myDrawerList(context),
                ],
              ),
            ),
          ),
          appBar: AppBar(
            title: const Text('تواصل معنا'),
            actions: [
              const Center(
                child: Text(
                  ' الوضع الليلي',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              FlutterSwitch(
                inactiveColor: Colors.white,
                inactiveToggleColor: Colors.grey,
                activeColor: primaryColor,
                activeText: 'Dark',
                height: 25,
                width: 50,
                activeTextColor: Colors.white,
                value: AppCubit.get(context).isDark,
                onToggle: (value) {
                  AppCubit.get(context).changeAppTheme();
                },
              ),
            ],
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
                        const Text(
                          'كيف يمكننا ان نساعدك',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultTextField(
                            lable: 'الاسم',
                            controller: nameController,
                            prefix: Icons.person,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'يجب ان تدخل الاسم';
                              }
                            },
                            context: context,
                            type: TextInputType.text),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextField(
                            lable: 'الهاتف',
                            controller: phoneController,
                            prefix: Icons.person,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'يجب ان تدخل رقم الهاتف';
                              }
                            },
                            context: context,
                            type: TextInputType.text),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextField(
                            lable: 'البريد الالكتروني',
                            controller: emailController,
                            prefix: Icons.email_outlined,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'يجب ان تدخل البريد الالكتروني';
                              }
                            },
                            context: context,
                            type: TextInputType.emailAddress),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextField(
                            lable: 'رسالتك',
                            controller: messageController,
                            prefix: Icons.message_outlined,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'يجب ان تدخل رسالتك';
                              }
                            },
                            context: context,
                            type: TextInputType.text),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: detailsController,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            hintText: 'معلومات اضافيه',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultButton(
                            onPress: () {
                              if (formKey.currentState!.validate()) {
                                AppCubit.get(context).contactUsData(
                                    message: messageController.text,
                                    email: emailController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    details: detailsController.text);
                              } else {}
                            },
                            text: 'ارسال'),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                color: Colors.grey,
                                height: 1,
                              ),
                            ),
                            Text(
                              ' حسابات التواصل الاجتماعي الخاصه بنا ',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.grey,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FlutterSocialButton(
                                mini: true,
                                onTap: () {},
                                buttonType: ButtonType.facebook),
                            FlutterSocialButton(
                                mini: true,
                                onTap: () {},
                                buttonType: ButtonType.twitter),
                            FlutterSocialButton(
                                mini: true,
                                onTap: () {},
                                buttonType: ButtonType.google),
                            FlutterSocialButton(
                                mini: true,
                                onTap: () {},
                                buttonType: ButtonType.linkedin),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
