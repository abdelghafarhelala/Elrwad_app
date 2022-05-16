import 'package:alrwad/components/components.dart';
import 'package:alrwad/modules/login/login.dart';
import 'package:alrwad/network/local/cache_Helper.dart';

String? token = '';
void logOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, const LoginScreen());
    }
  });
}
