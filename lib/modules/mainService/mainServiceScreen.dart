import 'package:alrwad/appCubit/app_cubit.dart';
import 'package:alrwad/appCubit/app_states.dart';
import 'package:alrwad/components/components.dart';
import 'package:alrwad/models/mainServicesModel/mainServicesModel.dart';
import 'package:alrwad/modules/categories/categories.dart';
import 'package:alrwad/modules/serviceDetailsScreen/serviceDetailsScreen.dart';
import 'package:alrwad/network/endpoints.dart';
import 'package:alrwad/shared/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainServicesScreen extends StatelessWidget {
  const MainServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! AppGetMainServicesLoadingState &&
              AppCubit.get(context).serviceLength > 0,
          builder: (context) => SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    int reverseIndex =
                        AppCubit.get(context).serviceLength - 1 - index;
                    return buildServiceItem(context,
                        AppCubit.get(context).services!.data![reverseIndex]);
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 1,
                  ),
                  itemCount: (AppCubit.get(context).services!.data!.length),
                ),
              ],
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget buildServiceItem(
  context,
  ServesData data,
) {
  return InkWell(
    onTap: () {
      if (data.id == 6) {
        navigateTo(context, Categories());
      } else {
        navigateTo(
            context,
            ServiceDetailsScreen(
              serviceData: data,
            ));
      }
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (data.img != null)
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
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
    ),
  );
}
