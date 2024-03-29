import 'package:admob_flutter/admob_flutter.dart';
import 'package:alrwad/appCubit/app_cubit.dart';
import 'package:alrwad/appCubit/app_states.dart';
import 'package:alrwad/components/components.dart';
import 'package:alrwad/models/ads_manger/ads_manger.dart';
import 'package:alrwad/models/categoryModel/categoryModel.dart';
import 'package:alrwad/models/mainServicesModel/mainServicesModel.dart';
import 'package:alrwad/modules/categories/categories.dart';
import 'package:alrwad/modules/doctors/doctors.dart';
import 'package:alrwad/modules/layoutScreen/layoutScreen.dart';
import 'package:alrwad/modules/serviceDetailsScreen/serviceDetailsScreen.dart';
import 'package:alrwad/network/endpoints.dart';
import 'package:alrwad/shared/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final List<String> imgList = [];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AdmobBannerSize admobBannerSize =
      AdmobBannerSize(height: 80, width: double.infinity.toInt());
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit.get(context).slider?.data?.forEach((element) {
          imgList.add(imagesLink + element.img!);
        });
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ConditionalBuilder(
              condition: state is! AppGetMainServicesLoadingState &&
                  state is! AppGetMainServicesLoadingState &&
                  AppCubit.get(context).categoryLength > 0 &&
                  AppCubit.get(context).sliderLength > 0 &&
                  AppCubit.get(context).serviceLength > 0,
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
                        height: 3,
                      ),
                      buildSliderItem(),
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      buildTextItem(
                          context: context,
                          screen: LayoutScreen(),
                          text: 'خدمات قد تفيدك'),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 220,
                        child: ConditionalBuilder(
                          condition: AppCubit.get(context).serviceLength > 0,
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                          builder: (context) => ListView.separated(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              width: 5,
                            ),
                            itemBuilder: (context, index) {
                              int reverseIndex =
                                  AppCubit.get(context).serviceLength -
                                      1 -
                                      index;
                              return buildServiceItem(
                                  AppCubit.get(context)
                                      .services
                                      ?.data?[reverseIndex],
                                  context);
                            },
                            itemCount: AppCubit.get(context).serviceLength,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      buildTextItem(
                          context: context,
                          screen: Categories(),
                          text: 'التخصصات المتاحه'),
                      ConditionalBuilder(
                        condition: AppCubit.get(context).categoryLength > 0,
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                        builder: (context) => ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                          itemBuilder: (context, index) => buildCategoryItem(
                              AppCubit.get(context).category?.data?[index].img,
                              AppCubit.get(context).category?.data?[index].name,
                              AppCubit.get(context).category?.data?[index].id,
                              AppCubit.get(context).category?.data?[index],
                              context),
                          itemCount: AppCubit.get(context).categoryLength,
                        ),
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
                image: NetworkImage(e),
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            )
            .toList(),
        options: CarouselOptions(
          height: 180,
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

Widget buildTextItem({context, Widget? screen, String? text, int index = 1}) =>
    Row(
      children: [
        Text(
          text!,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            AppCubit.get(context).currentIndex = index;
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

Widget buildServiceItem(ServesData? data, context) => InkWell(
      onTap: () {
        if (data!.id == 6) {
          navigateTo(context, Categories());
        } else {
          navigateTo(
              context,
              ServiceDetailsScreen(
                serviceData: data,
              ));
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

Widget buildCategoryItem(
    String? img, String? name, int? id, CategoryData? catData, context) {
  return InkWell(
    onTap: () {
      AppCubit.get(context).getDoctorsData(id!);
      navigateTo(
          context,
          DoctorsScreen(
            catId: id,
            catdata: catData,
          ));
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
