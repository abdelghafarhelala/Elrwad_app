import 'package:alrwad/appCubit/app_cubit.dart';
import 'package:alrwad/appCubit/app_states.dart';
import 'package:alrwad/components/components.dart';
import 'package:alrwad/models/categoryModel/categoryModel.dart';
import 'package:alrwad/models/doctorsModel/doctorsModel.dart';
import 'package:alrwad/modules/layoutScreen/layoutScreen.dart';
import 'package:alrwad/modules/login/login.dart';
import 'package:alrwad/modules/myDrawer/myDrawer.dart';
import 'package:alrwad/shared/colors.dart';
import 'package:alrwad/shared/const.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';

String company = '';
bool isCompany = false;

class BookingScreenDrawer extends StatefulWidget {
  // const BookingScreenDrawer({Key? key}) : super(key: key);
  final Data? categoryData;
  final Results? doctorData;
  BookingScreenDrawer({Key? key, this.categoryData, this.doctorData})
      : super(key: key);
  @override
  State<BookingScreenDrawer> createState() =>
      _BookingScreenDrawerState(categoryData, doctorData);
}

class _BookingScreenDrawerState extends State<BookingScreenDrawer> {
  final Data? categoryData;
  final Results? doctorData;

  _BookingScreenDrawerState(this.categoryData, this.doctorData);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppPostBookingSuccessState) {
          if (state.model.success == true) {
            showToast(text: 'تم الحجز بنجاح', state: ToastStates.success);
            navigateTo(context, LayoutScreen());
          } else {
            showToast(
                text: 'لم يتم الحجز الرجاء التأكد من البايانات المدخله',
                state: ToastStates.error);
          }
        }
      },
      builder: (context, state) {
        var formKey2 = GlobalKey<FormState>();
        var dateController = TextEditingController();
        var companyController = TextEditingController();
        var idController = TextEditingController();

        print(AppCubit.get(context).doctorsData.length);

        return Scaffold(
          drawer: defaultDrawer(context),
          appBar: defaultAppBar(context, 'الحجز', false),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'سجل حجزك وانت في بيتك ',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: TextEditingController(
                            text: categoryData?.name ?? 'لم تختار التخصص'),
                        enabled: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: TextEditingController(
                            text: doctorData?.name ?? 'لم تختار الطبيب'),
                        enabled: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Radio(
                                    value: '2',
                                    groupValue: company,
                                    onChanged: (val) {
                                      setState(() {
                                        company = val.toString();
                                        print(company);
                                        isCompany = false;
                                      });
                                    }),
                                const Text('شخصي')
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Radio(
                                    value: '1',
                                    groupValue: company,
                                    onChanged: (val) {
                                      setState(() {
                                        company = val.toString();
                                        print(company);
                                        isCompany = true;
                                      });
                                    }),
                                const Text('شركه')
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (isCompany == true)
                        defaultTextField(
                            controller: companyController,
                            lable: 'اسم الشركه',
                            prefix: Icons.home_filled,
                            validate: (String v) {
                              if (v.isEmpty) {
                                return 'يجب ان تدخل اسم الشركه';
                              }
                            },
                            context: context,
                            type: TextInputType.text),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultTextField(
                          lable: 'التاريخ',
                          prefix: Icons.date_range,
                          validate: (String s) {
                            if (s.isEmpty) {
                              return 'يجب ان تدخل التاريخ';
                            }
                          },
                          context: context,
                          type: TextInputType.datetime,
                          controller: dateController,
                          ontap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2030))
                                .then((value) {
                              String onlyDate =
                                  DateFormat("yyyy-MM-dd").format(value!);
                              dateController.text = onlyDate;
                            });
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultTextField(
                          controller: idController,
                          lable: 'رقم البطاقه',
                          prefix: Icons.account_box_rounded,
                          validate: (String v) {
                            if (v.isEmpty) {
                              return 'يجب ان تدخل رقم البطاقه ';
                            }
                          },
                          context: context,
                          type: TextInputType.number),
                      const SizedBox(
                        height: 20,
                      ),
                      if (token != null &&
                          categoryData?.id != null &&
                          doctorData?.id != null)
                        ConditionalBuilder(
                          condition: state is! AppPostBookingLoadingState,
                          fallback: (context) =>
                              const Center(child: LinearProgressIndicator()),
                          builder: (context) => defaultButton(
                              onPress: () {
                                if (formKey2.currentState!.validate()) {
                                  AppCubit.get(context).makeBooking(
                                      categoryId: categoryData!.id!,
                                      doctorId: doctorData!.id!,
                                      date: dateController.text,
                                      workKind: company,
                                      companyName: companyController.text,
                                      cardNumber: idController.text);
                                  // print(categoryData?.id);
                                  // print(companyController.text);
                                } else {}
                              },
                              text: ' احجز الآن'),
                        ),
                      if (token == null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                'لم تسجل الدخول.. ؟',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                  onPressed: () {
                                    navigateAndFinish(context, LoginScreen());
                                  },
                                  child: const Text(
                                    'سجل الآن ',
                                    style: TextStyle(fontSize: 18),
                                  )),
                            )
                          ],
                        ),
                      if (token != null &&
                          (categoryData?.id == null || doctorData?.id == null))
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ' لم تختار التخصص والطبيب ؟',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            TextButton(
                                onPressed: () {
                                  navigateAndFinish(context, LoginScreen());
                                },
                                child: const Text(
                                  'اختر الآن',
                                  style: TextStyle(fontSize: 18),
                                ))
                          ],
                        )
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
