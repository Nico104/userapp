import 'package:flutter/material.dart';

class MoreButton extends StatefulWidget {
  const MoreButton({
    super.key,
    this.moreOptions = const <Widget>[],
  });

  final List<Widget> moreOptions;

  @override
  State<MoreButton> createState() => _MoreButtonState();
}

class _MoreButtonState extends State<MoreButton> {
  void showMoreOpton() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: widget.moreOptions,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(8),
      child: GestureDetector(
        onTap: () => showMoreOpton(),
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
