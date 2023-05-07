import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'init_app.dart';

void main() async {
  // Needs to be called so that we can await for EasyLocalization.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    supportedLocales: const [Locale('en', 'US')],
    path: 'assets/translations', // <-- change the path of the translation files
    fallbackLocale: const Locale('en', 'US'),
    child: MultiProvider(
      providers: [
        // ChangeNotifierProvider<ConnectionService>(
        //     create: (_) => ConnectionService()),
        ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),
        // ChangeNotifierProvider<UploadStatus>(create: (_) => UploadStatus())
      ],
      child: const MyApp(),
    ),
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
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
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
