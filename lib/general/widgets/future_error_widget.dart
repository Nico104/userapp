import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/general/widgets/shy_button.dart';

//TODO localiization

class FutureErrorWidget extends StatelessWidget {
  const FutureErrorWidget({super.key, this.error});

  final Object? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(
            flex: 2,
          ),
          Image.asset("assets/tmp/connection_lost.png"),
          const Spacer(
            flex: 2,
          ),
          Text(
            "futureErrorTitle".tr(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            error.toString(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            "futureErrorLabel".tr(),
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          ShyButton(
            showUploadButton: true,
            onTap: () {
              Navigator.pop(context);
            },
            label: "futureErrorButtonLabel".tr(),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
