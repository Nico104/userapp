// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// import 'home.dart';
// import 'init_app.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Sizer(builder: (context, orientation, deviceType) {
//       return MaterialApp(
//         title: 'Flutter Demo',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: const InitApp(),
//       );
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/theme/theme_provider.dart';
import 'home.dart';
import 'package:provider/provider.dart';
import 'init_app.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      // ChangeNotifierProvider<ConnectionService>(
      //     create: (_) => ConnectionService()),
      ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),
      // ChangeNotifierProvider<UploadStatus>(create: (_) => UploadStatus())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) {
        return Sizer(builder: (context, orientation, deviceType) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: theme.getTheme(),
            home: const InitApp(),
          );
        });
      },
    );
  }
}
