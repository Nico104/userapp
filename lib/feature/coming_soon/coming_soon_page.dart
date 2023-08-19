import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 30.w,
              child: Image.asset("assets/tmp/coming_soon.png"),
            ),
            const SizedBox(height: 32),
            Text(
              "This page is comming soon",
              style: Theme.of(context).textTheme.labelLarge,
            )
          ],
        ),
      ),
    );
  }
}
