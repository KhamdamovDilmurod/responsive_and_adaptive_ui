import 'dart:math';

import 'package:flutter/material.dart';

import 'complex_ui/complex_ui.dart';
import 'custom_layout/custom_multichild_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'complex ui',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:CategorySectionsView(),
    );
  }
}
