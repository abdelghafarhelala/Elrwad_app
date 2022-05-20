import 'package:alrwad/appCubit/app_cubit.dart';
import 'package:alrwad/appCubit/app_states.dart';
import 'package:alrwad/components/components.dart';
import 'package:alrwad/models/categoryModel/categoryModel.dart';
import 'package:alrwad/models/doctorsModel/doctorsModel.dart';
import 'package:alrwad/modules/bookingScreenDrawer/bookingScreenDrawer.dart';
import 'package:alrwad/modules/categories/categories.dart';
import 'package:alrwad/modules/layoutScreen/layoutScreen.dart';
import 'package:alrwad/modules/login/login.dart';
import 'package:alrwad/shared/const.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

String company = '2';
bool isCompany = false;
var categoryName2;
var doctorName2;
List<String> Doctors2 = [];
List<String> categories2 = [];
int? categoryId2;
int? doctorId2;

class BookingScreen extends StatefulWidget {
  // const BookingScreen({Key? key}) : super(key: key);
  final CategoryData? categoryData;
  final Results? doctorData;
  BookingScreen({Key? key, this.categoryData, this.doctorData})
      : super(key: key);
  @override
  State<BookingScreen> createState() =>
      _BookingScreenState(categoryData, doctorData);
}

class _BookingScreenState extends State<BookingScreen> {
  final CategoryData? categoryData;
  final Results? doctorData;

  _BookingScreenState(this.categoryData, this.doctorData);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppPostBookingSuccessState) {
          if (state.model.success == true) {
            showToast(text: 'تم الحجز بنجاح', state: ToastStates.success);
            categoryName2 = null;
            doctorName2 = null;
            AppCubit.get(context).categoriesNames2 = [];
            AppCubit.get(context).getCategoryData();
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

        return Center(
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
                    DropdownButton(
                      // dropdownColor: Colors.red,
                      onTap: () {
                        // doctorName2 = '';
                      },

                      style: Theme.of(context).textTheme.bodyText2,
                      isExpanded: true,
                      hint: const Text('اختر التخصص'),
                      items: AppCubit.get(context)
                          .categoriesNames2
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          categoryName2 = val;
                        });
                        AppCubit.get(context).categoriesData.forEach((element) {
                          if (element.name == val) {
                            Doctors2.clear();
                            // Doctors.addAll(element.doctors!.cast());
                            element.doctors!.forEach((element) {
                              Doctors2.add(element.name!);
                            });
                          }
                        });
                      },
                      value: categoryName2,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DropdownButton(
                      onTap: () {},
                      style: Theme.of(context).textTheme.bodyText2,
                      isExpanded: true,
                      hint: const Text('اختر الطبيب'),
                      items: Doctors2.map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          )).toList(),
                      onChanged: (val) {
                        setState(() {
                          print(val);
                          doctorName2 = val.toString();
                        });
                      },
                      value: doctorName2,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Radio(
                                  autofocus: true,
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
                    if (isCompany == true)
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
                    if (token != null &&
                        categoryName2 != null &&
                        doctorName2 != null)
                      ConditionalBuilder(
                        condition: state is! AppPostBookingLoadingState,
                        fallback: (context) =>
                            const Center(child: LinearProgressIndicator()),
                        builder: (context) => defaultButton(
                            onPress: () {
                              if (formKey2.currentState!.validate()) {
                                AppCubit.get(context)
                                    .categoriesData
                                    .forEach((element) {
                                  if (element.name == categoryName2) {
                                    categoryId = element.id;
                                    element.doctors!.forEach((e) {
                                      if (e.name == doctorName2) {
                                        doctorId = e.id;
                                      }
                                    });
                                  }
                                });
                                AppCubit.get(context).makeBooking(
                                    categoryId: categoryId!,
                                    doctorId: doctorId!,
                                    date: dateController.text,
                                    workKind: company,
                                    companyName: companyController.text,
                                    cardNumber: idController.text);
                                print(categoryData?.id);
                                // print(company);
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
                        (categoryName2 == null || doctorName2 == null))
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ' لم تختار التخصص والطبيب ؟',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          TextButton(
                              onPressed: () {
                                navigateAndFinish(context, Categories());
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
        );
      },
    );
  }
}
