import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bindings/todo_binding.dart';
import 'views/home_view.dart';
import 'views/detail_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter GetX Todo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialBinding: TodoBinding(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomeView()),
        GetPage(name: '/detail', page: () => DetailView(index: 0)), // index will be passed via arguments
      ],
    );
  }
}
