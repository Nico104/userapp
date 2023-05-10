import 'package:flutter/material.dart';

class EmptyTag extends StatelessWidget {
  const EmptyTag({
    super.key,
    required this.dimension,
  });

  final double dimension;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: dimension,
        width: dimension,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: kElevationToShadow[2],
          borderRadius: BorderRadius.circular(30),
          // border: Border.all(
          //   width: 3,
          //   color: Colors.black,
          //   // strokeAlign: BorderSide.strokeAlignOutside,
          // ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.add),
              Text("Finma Tag"),
            ],
          ),
        ),
      ),
    );
  }
}