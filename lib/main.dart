import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bindings/todo_binding.dart';
import 'views/home/home_view.dart';
import 'views/detail/detail_view.dart';
import 'views/settings_view.dart';
import 'controllers/settings_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.put(SettingsController());
    return Obx(() => GetMaterialApp(
      title: 'Flutter GetX Todo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: settingsController.themeMode.value,
      initialBinding: TodoBinding(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomeView()),
        GetPage(name: '/detail', page: () => DetailView(index: 0)), // index will be passed via arguments
        GetPage(name: '/settings', page: () => SettingsView()),
      ],
    ));
  }
}
