import 'package:alrwad/appCubit/app_cubit.dart';
import 'package:alrwad/appCubit/app_states.dart';
import 'package:alrwad/components/components.dart';
import 'package:alrwad/modules/aboutUsScreen/aboutUs.dart';

import 'package:alrwad/modules/layoutScreen/layoutScreen.dart';
import 'package:alrwad/modules/login/login.dart';

import 'package:alrwad/shared/colors.dart';
import 'package:alrwad/shared/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';

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
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
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
          menuItem(context, Icons.support_rounded, 'الخدمات', LayoutScreen(),
              index: 1),
          menuItem(context, Icons.post_add, 'حجز ميعاد', LayoutScreen(),
              index: 3),
          menuItem(context, Icons.phone, 'تواصل معنا', LayoutScreen(),
              index: 2),
          menuItem(context, Icons.file_copy_outlined, 'عن التطبيق',
              const AboutUsScreen()),
          menuItem3(
            context,
            Icons.brightness_medium,
            ' الوضع الليلي',
          ),
          if (token == null)
            menuItem(
                context, Icons.person, 'تسجيل الدخول', const LoginScreen()),
          if (token != null)
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
  Widget menuItem(context, IconData icon, String text, Widget widget,
      {int index = 0}) {
    return Material(
      child: InkWell(
        onTap: () {
          navigateTo(context, widget);
          AppCubit.get(context).currentIndex = index;
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
          AppCubit.get(context).logOut(context);
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

  Widget menuItem3(
    context,
    IconData icon,
    String text,
  ) {
    return Material(
      child: InkWell(
        onTap: () {},
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
              FlutterSwitch(
                inactiveColor: Colors.white,
                inactiveToggleColor: Colors.grey,
                activeColor: primaryColor,
                activeText: 'Dark',
                height: 25,
                width: 60,
                inactiveSwitchBorder: Border.all(color: Colors.black),
                activeTextColor: Colors.white,
                value: AppCubit.get(context).isDark,
                onToggle: (value) {
                  AppCubit.get(context).changeAppTheme();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
