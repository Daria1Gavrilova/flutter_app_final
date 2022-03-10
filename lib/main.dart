import 'package:flutter/material.dart';
import 'us_counter.dart';
import 'user_inf.dart';
import 'pages_auth.dart';
import 'registration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Сохранение и загрузка данных',
        initialRoute: '/',
        routes: {
          '/': (context) => Pagesauthorization(),
          '/ registration': (context) => const Registration(),
          '/ counter': (context) => const Counter(),
          '/ infoUser': (context) => InfoUser(),
        });
  }
}