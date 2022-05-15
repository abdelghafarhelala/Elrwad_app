import 'package:alrwad/appCubit/app_cubit.dart';
import 'package:alrwad/appCubit/app_states.dart';
import 'package:alrwad/components/components.dart';
import 'package:alrwad/modules/aboutUsScreen/aboutUs.dart';
import 'package:alrwad/modules/contactUsScreen/contactUs.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'User Name',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                accountEmail: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'example@gmail.com',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=996&t=st=1648830402~exp=1648831002~hmac=23bb5c012cffe2b975c10240fb7aa2f906cd61fc0e106b73ae52d85af1159554',
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                decoration: const BoxDecoration(color: Colors.white),
              ),
              ListTile(
                leading: const Icon(Icons.support_rounded),
                title: Text('الخدمات'),
              ),
              ListTile(
                leading: const Icon(Icons.phone),
                title: Text('تواصل معنا'),
                onTap: () {
                  navigateTo(context, ContactUsScreen());
                },
              ),
              ListTile(
                leading: const Icon(Icons.file_copy_outlined),
                title: Text('عن التطبيق'),
                onTap: () {
                  navigateTo(context, AboutUsScreen());
                },
              ),
              ListTile(
                leading: const Icon(Icons.brightness_high_sharp),
                title: Text('الوضع'),
                onTap: () {
                  AppCubit.get(context).changeAppTheme();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
