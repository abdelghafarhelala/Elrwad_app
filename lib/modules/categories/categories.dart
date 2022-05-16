import 'package:alrwad/appCubit/app_cubit.dart';
import 'package:alrwad/appCubit/app_states.dart';
import 'package:alrwad/components/components.dart';
import 'package:alrwad/models/categoryModel/categoryModel.dart';
import 'package:alrwad/modules/doctors/doctors.dart';
import 'package:alrwad/modules/myDrawer/myDrawer.dart';
import 'package:alrwad/network/endpoints.dart';
import 'package:alrwad/shared/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var data = AppCubit.get(context).category;

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
            title: Text('التخصصات'),
            actions: [
              const Center(
                child: Text(
                  'الوضع',
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
            condition: state is! AppGetCategoriesLoadingState,
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
            builder: (context) => SingleChildScrollView(
              child: Container(
                color: Colors.grey[300],
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: 1 / 1.4,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(
                      AppCubit.get(context).category!.data!.length,
                      (index) => (buildCategoryItem(
                          data!.data?[index],
                          data.data?[index].img ??
                              '2022_03_23_01_53_38_amrad-alklb.jpg',
                          AppCubit.get(context).category?.data?[index].name,
                          context))),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget buildCategoryItem(Data? data, image, name, context) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      InkWell(
        onTap: () {
          AppCubit.get(context).getDoctorsData(
            data?.id,
          );
          navigateTo(
              context,
              DoctorsScreen(
                catId: data?.id,
                catdata: data,
              ));
        },
        child: Card(
            elevation: 5,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              // alignment: AlignmentDirectional.bottomEnd,
              children: [
                Image(
                  image: NetworkImage((imagesLink + image)),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    name,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                )
              ],
            )),
      ),
    ]);
