import 'package:alrwad/appCubit/app_cubit.dart';
import 'package:alrwad/appCubit/app_states.dart';
import 'package:alrwad/components/components.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_button/flutter_social_button.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppPostContactSuccessState) {
          showToast(text: state.model.errorMessage, state: ToastStates.success);
        }
        elseif(AppPostContactErrorState) {
          showToast(
              text: 'لم يتم ارسال البيانات برجاء المحاوله مره اخري',
              state: ToastStates.error);
        }
      },
      builder: (context, state) {
        var emailController = TextEditingController();
        var nameController = TextEditingController();
        var phoneController = TextEditingController();
        var detailsController = TextEditingController();

        var formKey = GlobalKey<FormState>();
        return Center(
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
                        height: 15,
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
                          type: TextInputType.phone),
                      const SizedBox(
                        height: 15,
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
                        height: 15,
                      ),
                      TextFormField(
                        controller: detailsController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          hintText: 'رسالتك',
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ConditionalBuilder(
                        condition: state is! AppPostContactLoadingState,
                        fallback: (context) =>
                            const Center(child: LinearProgressIndicator()),
                        builder: (context) => defaultButton(
                            onPress: () {
                              if (formKey.currentState!.validate()) {
                                AppCubit.get(context).contactUsData(
                                  message: detailsController.text,
                                  email: emailController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              } else {}
                            },
                            text: 'ارسال'),
                      ),
                      const SizedBox(
                        height: 20,
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
        );
      },
    );
  }
}
