import 'dart:math';

import 'package:flutter/material.dart';
import 'package:inventaire_flutter_app/pages/inventory_product_page.dart';

import 'pages/my_home_page.dart';

void main() {
  runApp(const MyApp());
}

Color contrastColor(Color iColor)
{
  // Calculate the perceptive luminance (aka luma) - human eye favors green color... 
  final double luma = ((0.299 * iColor.red) + (0.587 * iColor.green) + (0.114 * iColor.blue)) / 255;

  // Return black for bright colors, white for dark colors
  return luma > 0.5 ? Colors.black : Colors.white;
}

Color randomMaterialColor()
{
  return Colors.primaries[Random().nextInt(Colors.primaries.length)];
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory_flutter_app',
      home: const MyHomePage(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,

        primaryColor: Colors.white,
        //accentColor: const Color(0xfff70c36), // These are the color of the ISATI
        colorScheme: ThemeData().colorScheme.copyWith(secondary: const Color(0xfff70c36)),
        cardColor: Colors.white,

        appBarTheme: const AppBarTheme(
          // color: Colors.white,
          elevation: 0,
        ),

        fontFamily: "Futura Light",

        textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 48.0, fontWeight: FontWeight.w800, color: Colors.black87),
            headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w300, color: Colors.black87),
            subtitle1: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w800, color: Colors.black87)
        ),

        visualDensity: VisualDensity.adaptivePlatformDensity,

      ),
    );
  }
}





