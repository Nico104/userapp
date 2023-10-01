import 'package:flutter/material.dart';
import 'package:userapp/general/widgets/shy_button.dart';

class FutureErrorWidget extends StatelessWidget {
  const FutureErrorWidget({super.key, this.error});

  final Object? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Spacer(),
          Image.asset("assets/tmp/connection_lost.png"),
          Spacer(),
          Text(
            "No internet connection",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            "Please check you internet connection and try again",
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
          Spacer(),
          ShyButton(
            showUploadButton: true,
            onTap: () {
              Navigator.pop(context);
            },
            label: "Try again",
          ),
          Spacer(),
        ],
      ),
    );
  }
}
