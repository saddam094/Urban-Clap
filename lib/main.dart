import 'dart:ui';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urban_clap/navigate.dart';

Future<void> main() async {
  FlutterView? flutterView = PlatformDispatcher.instance.views.firstOrNull;
  if (flutterView == null || flutterView.physicalSize.isEmpty) {
    PlatformDispatcher.instance.onMetricsChanged = () {
      flutterView = PlatformDispatcher.instance.views.firstOrNull;
      if (flutterView != null && !flutterView!.physicalSize.isEmpty) {
        PlatformDispatcher.instance.onMetricsChanged = null;
        WidgetsFlutterBinding.ensureInitialized();
        runApp(const MyApp());
      }
    };
  } else {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(const MyApp());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return ScreenUtilInit(
      designSize: Size(w, h),
      builder: (context, child) {
        return GetMaterialApp(
          // getPages: AppRoutes.appRoutes(),
          title: 'One App',
          debugShowCheckedModeBanner: false,
          theme: FlexThemeData.light(
            scheme: FlexScheme.red,
            surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
            blendLevel: 10,
            appBarStyle: FlexAppBarStyle.background,
            bottomAppBarElevation: 1.0,
            subThemesData: const FlexSubThemesData(
              blendOnLevel: 20,
              blendTextTheme: true,
              useTextTheme: true,
              useM2StyleDividerInM3: true,
              thickBorderWidth: 2.0,
              elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
              elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
              outlinedButtonOutlineSchemeColor: SchemeColor.primary,
              toggleButtonsBorderSchemeColor: SchemeColor.primary,
              segmentedButtonSchemeColor: SchemeColor.primary,
              segmentedButtonBorderSchemeColor: SchemeColor.primary,
              unselectedToggleIsColored: true,
              sliderValueTinted: true,
              // inputDecoratorSchemeColor: SchemeColor.primary,
              inputDecoratorBackgroundAlpha: 15,
              inputDecoratorRadius: 10.0,
              inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
              chipRadius: 10.0,
              popupMenuRadius: 6.0,
              popupMenuElevation: 6.0,
              alignedDropdown: true,
              useInputDecoratorThemeInDialogs: true,
              appBarScrolledUnderElevation: 8.0,
              drawerWidth: 280.0,
              drawerIndicatorSchemeColor: SchemeColor.primary,
              bottomNavigationBarMutedUnselectedLabel: false,
              bottomNavigationBarMutedUnselectedIcon: false,
              menuRadius: 6.0,
              menuElevation: 6.0,
              menuBarRadius: 0.0,
              menuBarElevation: 1.0,
              navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
              navigationBarMutedUnselectedLabel: false,
              navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
              navigationBarMutedUnselectedIcon: false,
              navigationBarIndicatorSchemeColor: SchemeColor.primary,
              navigationBarIndicatorOpacity: 1.00,
              navigationBarElevation: 2.0,
              navigationBarHeight: 70.0,
              navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
              navigationRailMutedUnselectedLabel: false,
              navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
              navigationRailMutedUnselectedIcon: false,
              navigationRailIndicatorSchemeColor: SchemeColor.primary,
              navigationRailIndicatorOpacity: 1.00,
            ),
            visualDensity: FlexColorScheme.comfortablePlatformDensity,
            useMaterial3: true,
            swapLegacyOnMaterial3: true,
            fontFamily: GoogleFonts.roboto().fontFamily,
          ),
          themeMode: ThemeMode.system,

          home: const Navigate(),
        );
      },
    );
  }
}



// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
