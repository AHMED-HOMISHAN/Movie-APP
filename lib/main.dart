import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/components/constants.dart';
import 'package:movieapp/cubit/homeCubit.dart';
import 'package:movieapp/layout/MoiveLayout.dart';
import 'package:movieapp/API/API.dart';
import 'package:movieapp/states/homeStates.dart';

void main() {
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit()..getHomeData(),
        )
      ],
      child: BlocConsumer<HomeCubit, HomeStates>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Netflix',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColor: darkColor,
                canvasColor: darkColor,
                appBarTheme: const AppBarTheme(
                    centerTitle: true,
                    elevation: 0.0,
                    color: darkColor,
                    titleTextStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: primaryColorAccent)),
                colorScheme:
                    ColorScheme.fromSeed(seedColor: primaryColorAccent),
                useMaterial3: true,
              ),
              home: const MovieLayout(),
            );
          },
          listener: (context, state) {}),
    );
  }
}
