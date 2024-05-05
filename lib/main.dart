import 'package:flutter/material.dart';
import 'package:shop_flutter/data/product.dart';
import 'package:shop_flutter/data/repo/banner_repository.dart';
import 'package:shop_flutter/data/repo/product_repository.dart';
import 'package:shop_flutter/theme.dart';
import 'package:shop_flutter/ui/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    productRepository.getAll(ProductSort.latest).then((value) {
      debugPrint(value.toString());
    }).catchError((e) {
      debugPrint(e.toString());
    });

    bannerRepository.getAll().then((value) {
      debugPrint(value.toString());
    }).catchError((e) {
      debugPrint(e.toString());
    });

    const defaultTextStyle = TextStyle(
      fontFamily: 'iran',
      color: LightThemeColors.primaryTextColor,
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        textTheme: TextTheme(
          bodySmall: defaultTextStyle.apply(
              color: LightThemeColors.secondaryTextColor),
          bodyMedium: defaultTextStyle,
          titleLarge: defaultTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        colorScheme: const ColorScheme.light(
          primary: LightThemeColors.primaryColor,
          secondary: LightThemeColors.secondaryColor,
          onSecondary: Colors.white,
        ),
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      home: const Directionality(
          textDirection: TextDirection.rtl,
          child: HomeScreen()),
    );
  }
}
