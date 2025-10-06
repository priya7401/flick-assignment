import 'package:flick_assignment/bloc/home/home_bloc.dart';
import 'package:flick_assignment/bloc/home/home_event.dart';
import 'package:flick_assignment/services/data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'view/home_screen.dart';

final DataService dataService = DataService();

void main() {
  runApp(
    BlocProvider(
      create: (context) => HomeBloc(dataService: dataService)..add(const LoadHomeDataEvent()),
      child: const FlickApp(),
    ),
  );
}

/// Root widget of the Flick OTT application
class FlickApp extends StatelessWidget {
  const FlickApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Flick - OTT App',
          debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Dark theme for OTT app
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
        primaryColor: Colors.red,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        colorScheme: const ColorScheme.dark(
          primary: Colors.red,
          secondary: Colors.red,
          surface: Colors.black,
        ),
        // Custom text theme for better readability
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      home: const HomeScreen(),
        );
      },
    );
  }
}
