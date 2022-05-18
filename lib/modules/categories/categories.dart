import 'package:alrwad/appCubit/app_cubit.dart';
import 'package:alrwad/appCubit/app_states.dart';
import 'package:alrwad/components/components.dart';
import 'package:alrwad/models/categoryModel/categoryModel.dart';
import 'package:alrwad/modules/doctors/doctors.dart';
import 'package:alrwad/modules/myDrawer/myDrawer.dart';
import 'package:alrwad/network/endpoints.dart';
import 'package:alrwad/network/local/cache_Helper.dart';
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
          drawer: defaultDrawer(context),
          appBar: defaultAppBar(context, 'التخصصات', false),
          body: ConditionalBuilder(
            condition: state is! AppGetCategoriesLoadingState &&
                AppCubit.get(context).categoryLength > 0,
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
                      AppCubit.get(context).categoryLength,
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
          // CacheHelper.sharedPreferences.setString('categoryId', data!.name!);
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
