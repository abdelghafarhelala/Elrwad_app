import 'package:alrwad/appCubit/app_cubit.dart';
import 'package:alrwad/appCubit/app_states.dart';
import 'package:alrwad/components/components.dart';
import 'package:alrwad/models/mainServicesModel/mainServicesModel.dart';
import 'package:alrwad/modules/categories/categories.dart';
import 'package:alrwad/modules/doctors/doctors.dart';
import 'package:alrwad/modules/serviceScreen/serviceScreen.dart';
import 'package:alrwad/network/endpoints.dart';
import 'package:alrwad/shared/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final List<String> imgList = [
  'assets/images/safe1.jpg',
  'assets/images/safe2.jpg',
  'assets/images/safe3.jpg',
  'assets/images/safe4.jpg',
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ConditionalBuilder(
              condition: state is! AppGetMainServicesLoadingState &&
                  state is! AppGetMainServicesLoadingState,
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
              builder: (context) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: RichText(
                          text: TextSpan(
                            text: 'صحتك',
                            style: Theme.of(context).textTheme.bodyText1,
                            children: [
                              TextSpan(
                                text: ' شعارنا  ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: primaryColor),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      buildSliderItem(),
                      const SizedBox(
                        height: 10,
                      ),
                      buildTextItem(
                          context: context,
                          screen: const ServicesScreen(),
                          text: 'خدمات قد تفيدك'),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 220,
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 5,
                          ),
                          itemBuilder: (context, index) => buildServiceItem(
                              AppCubit.get(context).services?.data?[index],
                              context),
                          itemCount:
                              AppCubit.get(context).services!.data!.length,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      buildTextItem(
                          context: context,
                          screen: Categories(),
                          text: 'التخصصات المتاحه'),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemBuilder: (context, index) => buildCategoryItem(
                            AppCubit.get(context).category?.data?[index].img,
                            AppCubit.get(context).category?.data?[index].name,
                            AppCubit.get(context).category?.data?[index].id,
                            context),
                        itemCount: AppCubit.get(context).category!.data!.length,
                      ),
                    ],
                  ),
                );
              }),
        );
      },
    );
  }
}

Widget buildSliderItem() => Card(
      elevation: 5,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: CarouselSlider(
        items: imgList
            .map(
              (e) => Image(
                image: AssetImage(e),
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            )
            .toList(),
        options: CarouselOptions(
          height: 250,
          initialPage: 0,
          viewportFraction: 1,
          autoPlay: true,
          autoPlayAnimationDuration: const Duration(seconds: 1),
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
          reverse: false,
        ),
      ),
    );

Widget buildTextItem({context, Widget? screen, String? text}) => Row(
      children: [
        Text(
          text!,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            navigateTo(context, screen);
          },
          child: Text(
            'عرض الكل',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: primaryColor, fontWeight: FontWeight.w600, fontSize: 17),
          ),
        ),
      ],
    );

Widget buildServiceItem(Data? data, context) => InkWell(
      onTap: () {
        if (data!.id == 6) {
          navigateTo(context, Categories());
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image(
                image: NetworkImage(imagesLink + data!.img!),
                width: 200,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 200,
              height: 30,
              color: Colors.black.withOpacity(.7),
              child: Center(
                child: Text(
                  data.name!,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget buildCategoryItem(String? img, String? name, int? id, context) {
  return InkWell(
    onTap: () {
      AppCubit.get(context).getDoctorsData(id!);
      navigateTo(context, DoctorsScreen(catId: id));
    },
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          if (img != null)
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image(
                image: NetworkImage(
                  (imagesLink + img),
                ),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 230,
              ),
            ),
          if (img == null)
            const ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image(
                image: AssetImage('assets/images/def.jpg'),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 230,
              ),
            ),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: double.infinity,
            color: Colors.black.withOpacity(.7),
            child: Center(
              child: Text(
                name!,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    ),
  );
}
