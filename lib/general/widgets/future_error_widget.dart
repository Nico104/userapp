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
          const Spacer(),
          Image.asset("assets/tmp/connection_lost.png"),
          const Spacer(),
          Text(
            "No internet connection",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            error.toString(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            "Please check you internet connection and try again",
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          ShyButton(
            showUploadButton: true,
            onTap: () {
              Navigator.pop(context);
            },
            label: "Try again",
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
