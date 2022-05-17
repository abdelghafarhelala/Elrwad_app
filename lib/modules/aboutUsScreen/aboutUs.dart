import 'package:alrwad/components/components.dart';
import 'package:alrwad/modules/myDrawer/myDrawer.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: defaultDrawer(context),
      appBar: defaultAppBar(context, 'عن التطبيق', false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Card(
                elevation: 8,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset(
                  'assets/images/about.jpg',
                  fit: BoxFit.cover,
                  height: 250,
                  width: double.infinity,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      '''  يهدف تطبيق الرواد الي راحه المريض او العميل عن طريق انه يتيح للمريض الحجز من المنزل ويتيح له كذلك اختيار الطبيب المناسب والميعاد المناسب له كما يتيح له ايضا رؤيه جميع التخصصات المتاحه وجميع الاقسام ويتميز ايضا بسهوله التعامل معه واستخدامه سهل جدا اذا واجهتك اي مشكله يمكنك التواصل معنا  ''',
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultButton(onPress: () {}, text: 'تواصل معنا')
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
