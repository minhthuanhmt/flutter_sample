import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sample/app/modules/home/binding.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/data/services/storage/services.dart';
import 'app/modules/home/view.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      home: const HomePage(),
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
    );
  }
}
