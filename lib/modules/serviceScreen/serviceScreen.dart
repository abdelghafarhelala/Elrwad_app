import 'package:alrwad/appCubit/app_cubit.dart';
import 'package:alrwad/appCubit/app_states.dart';
import 'package:alrwad/components/components.dart';
import 'package:alrwad/models/mainServicesModel/mainServicesModel.dart';
import 'package:alrwad/modules/categories/categories.dart';
import 'package:alrwad/modules/myDrawer/myDrawer.dart';

import 'package:alrwad/network/endpoints.dart';
import 'package:alrwad/shared/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! AppGetMainServicesLoadingState,
          builder: (context) => Scaffold(
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
              title: const Text('الخدمات'),
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
            body: SingleChildScrollView(
              child: Expanded(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        navigateTo(context, Categories());
                      },
                      child: buildServiceItem2(
                          context,
                          AppCubit.get(context).services!.data![
                              (AppCubit.get(context).services!.data!.length) -
                                  1]),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildServiceItem2(
                          context,
                          AppCubit.get(context).services!.data![index]),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 1,
                      ),
                      itemCount:
                          (AppCubit.get(context).services!.data!.length) - 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget buildServiceItem2(context, ServesData data) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (data.img != null)
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image(
                image: NetworkImage(
                  (imagesLink + data.img!),
                ),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            ),
          if (data.img == null)
            const Image(
              image: AssetImage('assets/images/doctor2.jpg'),
              fit: BoxFit.cover,
              width: 100,
              height: 120,
            ),
          const SizedBox(
            height: 10,
          ),
          Text(
            data.name!,
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: primaryColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // const SizedBox(
          //   height: 5,
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              data.details!,
              style: Theme.of(context).textTheme.caption,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    ),
  );
}
