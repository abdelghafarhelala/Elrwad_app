import 'package:alrwad/appCubit/app_cubit.dart';
import 'package:alrwad/appCubit/app_states.dart';
import 'package:alrwad/modules/myDrawer/myDrawer.dart';
import 'package:alrwad/shared/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';

class LayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
            title: Text(cubit.titles[cubit.currentIndex]),
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
          body: ConditionalBuilder(
              condition: state is! AppGetMainServicesLoadingState &&
                  state is! AppGetMainServicesLoadingState,
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
              builder: (context) => cubit.appScreens[cubit.currentIndex]),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.buttomItems,
            onTap: (index) {
              cubit.changeAppNav(index);
            },
            currentIndex: cubit.currentIndex,
          ),
        );
      },
    );
  }
}
