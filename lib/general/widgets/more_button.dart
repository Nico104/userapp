import 'package:flutter/material.dart';

import 'custom_nico_modal.dart';

class MoreButton extends StatefulWidget {
  const MoreButton({
    super.key,
    this.moreOptions = const <Widget>[],
    this.child,
  });

  final List<Widget> moreOptions;
  final Widget? child;

  @override
  State<MoreButton> createState() => _MoreButtonState();
}

class _MoreButtonState extends State<MoreButton> {
  void showMoreOpton() {
    showCustomNicoModalBottomSheet(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: widget.moreOptions,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showMoreOpton(),
      child: widget.child ??
          Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey,
                  width: 0.1,
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.more_vert),
            ),
          ),
    );
  }
}
