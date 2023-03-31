import 'package:flutter/material.dart';
import '../../../styles/text_styles.dart';
import '../../../theme/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeSettings extends StatefulWidget {
  const ThemeSettings({super.key});

  @override
  State<ThemeSettings> createState() => _ThemeSettingsState();
}

class _ThemeSettingsState extends State<ThemeSettings> {
  final double _appBarElevationActivated = 8;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Theme"),
      ),
      body: Consumer<ThemeNotifier>(
        builder: (context, theme, _) => Column(
          children: [
            OutlinedButton(
              onPressed: () {
                if (theme.getTheme() == theme.darkTheme) {
                  theme.setLightTheme();
                }
              },
              child: const Text("Light"),
            ),
            OutlinedButton(
              onPressed: () {
                if (theme.getTheme() == theme.lightTheme) {
                  theme.setDarkTheme();
                }
              },
              child: const Text("Dark"),
            ),
          ],
        ),
      ),
    );
  }
}
