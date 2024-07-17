import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lms/core/local/local.dart';
import 'package:lms/core/local/local_controller.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/utils/injector.dart';
import 'package:lms/core/router/app_router.dart';
import 'package:lms/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  await DependencyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocaleController localeController = Get.find();
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => GetMaterialApp(
        getPages: AppRouter.pages,
        debugShowCheckedModeBanner: false,
        locale: localeController.initialLang.value,
        translations: MyLocal(),
        initialRoute: box.read('token') == null
            ? AppRouter.loginScreen
            : AppRouter.homeScreen,
      ),
    );
  }
}
