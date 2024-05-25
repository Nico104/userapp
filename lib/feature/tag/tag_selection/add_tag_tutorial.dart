import 'package:flutter/material.dart';

class AddTagTutorial extends StatelessWidget {
  const AddTagTutorial({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Text(
          "Adding Your Dog Tags to Your Account",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 32),
        Text(
          "1. In the text field above, either enter the activation code provided with your dog tag or Scan the QR code on the back of the tag.",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 12),
        Text(
          "2. Click \"Submit\" or \"Add Tag\" to proceed.",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 12),
        Text(
          "3. Follow any on-screen instructions to complete the process.",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 12),
        Text(
          "4. Once done, your dog tag is now linked to your account.",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
