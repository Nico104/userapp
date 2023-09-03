import 'package:flutter/material.dart';

class ComponentTitle extends StatelessWidget {
  const ComponentTitle({super.key, required this.text, this.suffix});

  final String text;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            suffix ?? const SizedBox(),
          ],
        ),
        const SizedBox(
          height: 16,
        )
      ],
    );
  }
}

// class ComponentTitle extends StatelessWidget {
//   const ComponentTitle({super.key, required this.text, this.suffix});

//   final String text;
//   final Widget? suffix;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               text,
//               style: Theme.of(context).textTheme.titleMedium,
//             ),
//             suffix ?? const SizedBox(),
//           ],
//         ),
//         const SizedBox(
//           height: 22,
//         )
//       ],
//     );
//   }
// }
