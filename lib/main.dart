import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_block/blocks/home_cubit.dart';
import 'package:last_block/pages/home.dart';
import 'package:last_block/services/retrofit_net.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    RestClient(Dio()).getTask().then((value) {
      if (value.isNotEmpty) {
        print(value.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiBlocProvider(providers: [
          BlocProvider<Home_Cubit>(
            create: (context) => Home_Cubit(),
          )
        ], child: Home()));
  }
}
