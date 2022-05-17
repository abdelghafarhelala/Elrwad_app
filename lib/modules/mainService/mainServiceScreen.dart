import 'package:alrwad/appCubit/app_cubit.dart';
import 'package:alrwad/appCubit/app_states.dart';
import 'package:alrwad/components/components.dart';
import 'package:alrwad/models/mainServicesModel/mainServicesModel.dart';
import 'package:alrwad/modules/categories/categories.dart';
import 'package:alrwad/modules/serviceScreen/serviceScreen.dart';
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
          condition: state is! AppGetMainServicesLoadingState,
          builder: (context) => SingleChildScrollView(
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
                        context, AppCubit.get(context).services!.data![index]),
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
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
