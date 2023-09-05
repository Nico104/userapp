import 'package:flutter/material.dart';

class CustomOpenContainer extends StatelessWidget {
  const CustomOpenContainer(
      {super.key, required this.closedContainer, required this.openRoute});

  final Widget closedContainer;
  final Widget openRoute;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Hero(
              tag: openRoute.toString(),
              child: openRoute,
            ),
          ),
        );
      },
      child: Hero(
        tag: openRoute.toString(),
        child: closedContainer,
      ),
    );
  }
}
