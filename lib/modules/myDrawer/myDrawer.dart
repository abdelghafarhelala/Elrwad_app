import 'package:alrwad/appCubit/app_cubit.dart';
import 'package:alrwad/appCubit/app_states.dart';
import 'package:alrwad/components/components.dart';
import 'package:alrwad/modules/aboutUsScreen/aboutUs.dart';
import 'package:alrwad/modules/bookingScreen%20copy/bookingScreen.dart';
import 'package:alrwad/modules/contactUsScreenInDrawer/contactUs.dart';
import 'package:alrwad/modules/layoutScreen/layoutScreen.dart';
import 'package:alrwad/modules/serviceScreen/serviceScreen.dart';
import 'package:alrwad/shared/colors.dart';
import 'package:alrwad/shared/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userData = AppCubit.get(context).profile;
        return Container(
          color: primaryColor,
          width: double.infinity,
          height: 200,
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                height: 70,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(userData?.data?.profilePhotoUrl ??
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwnYnwftDUSjsQmLQvMBZ2pwDXhAJiIdfKvg&usqp=CAU'),
                    )),
              ),
              Text(
                userData?.data?.name ?? 'User Name',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                userData?.data?.email ?? 'userName@example.com',
                style: TextStyle(color: Colors.grey[200], fontSize: 14),
              ),
            ],
          ),
        );
      },
    );
  }

//Build Drawer List
  Widget myDrawerList(context) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem(context, Icons.home, 'الرئيسيه', LayoutScreen()),
          menuItem(context, Icons.support_rounded, 'الخدمات',
              const ServicesScreen()),
          menuItem(context, Icons.post_add, 'حجز ميعاد', BookingScreenDrawer()),
          menuItem(context, Icons.phone, 'تواصل معنا',
              const ContactUsDrawerScreen()),
          menuItem(context, Icons.file_copy_outlined, 'عن التطبيق',
              const AboutUsScreen()),
          menuItem2(
            context,
            Icons.logout,
            'تسجيل الخروج',
          ),
        ],
      ),
    );
  }

// Build menu of Drawer
  Widget menuItem(context, IconData icon, String text, Widget widget) {
    return Material(
      child: InkWell(
        onTap: () {
          navigateTo(context, widget);
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Expanded(child: Icon(icon)),
              Expanded(
                  flex: 3,
                  child: Text(
                    text,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )),
            ],
          ),
        ),
      ),
    );
  }

// Build menu2 of Drawer
  Widget menuItem2(
    context,
    IconData icon,
    String text,
  ) {
    return Material(
      child: InkWell(
        onTap: () {
          logOut(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Expanded(child: Icon(icon)),
              Expanded(
                  flex: 3,
                  child: Text(
                    text,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )),
            ],
          ),
        ),
      ),
    );
  }

//Build Dialog of language

  // Widget buildDialog(context) {
  //   return Dialog(
  //     insetAnimationCurve: Curves.linearToEaseOut,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
  //     child: Container(
  //       padding: EdgeInsets.all(20),
  //       height: 300,
  //       width: 300,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           Text(
  //             '${getLang(context, 'chooseYourLanguage')}',
  //             style: const TextStyle(
  //                 color: Colors.black, fontWeight: FontWeight.w500),
  //           ),
  //           const SizedBox(
  //             height: 80,
  //           ),
  //           Row(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Expanded(
  //                 child: MaterialButton(
  //                   onPressed: () {
  //                     AppCubit.get(context).changeLang();
  //                   },
  //                   color: primaryColor,
  //                   textColor: Colors.white,
  //                   child: Text('${getLang(context, 'arabic')}'),
  //                 ),
  //               ),
  //               const SizedBox(
  //                 width: 10,
  //               ),
  //               Expanded(
  //                 child: MaterialButton(
  //                   onPressed: () {
  //                     AppCubit.get(context).changeLang();
  //                   },
  //                   color: primaryColor,
  //                   textColor: Colors.white,
  //                   child: Text('${getLang(context, 'english')}'),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           const SizedBox(
  //             height: 30,
  //           ),
  //           Row(
  //             children: [
  //               Expanded(
  //                 child: MaterialButton(
  //                   onPressed: () {
  //                     navigateAndFinish(context, HomePage());
  //                   },
  //                   textColor: Colors.white,
  //                   color: primaryColor,
  //                   child: Text('${getLang(context, 'start')}'),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
