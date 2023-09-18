import 'package:flutter/material.dart';

import 'custom_flexible_space_bar.dart';

class CustomNicoScrollView extends StatefulWidget {
  const CustomNicoScrollView({
    super.key,
    required this.title,
    required this.body,
    required this.onScroll,
    this.actions,
    this.fillRemaining = false,
    this.background,
    this.expandedHeight = 140,
  });

  final Widget title;
  final Widget body;
  final VoidCallback onScroll;
  final List<Widget>? actions;
  final bool fillRemaining;
  final Widget? background;
  final double expandedHeight;

  @override
  State<CustomNicoScrollView> createState() => _CustomNicoScrollViewState();
}

class _CustomNicoScrollViewState extends State<CustomNicoScrollView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      widget.onScroll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            stretch: true,
            expandedHeight: widget.expandedHeight,
            actions: widget.actions,
            // automaticallyImplyLeading: false,
            flexibleSpace: MyFlexibleSpaceBar(
              titlePaddingTween: EdgeInsetsTween(
                  begin: EdgeInsets.only(left: 16.0, bottom: 16),
                  end: EdgeInsets.only(left: 72.0, bottom: 16)),
              title: widget.title,
              // titlePadding: EdgeInsets.all(0), centerTitle: false,
              // centerTitle: true,
              background: widget.background,
            ),
          ),
          widget.fillRemaining
              ? SliverFillRemaining(
                  hasScrollBody: false,
                  child: widget.body,
                )
              : SliverToBoxAdapter(
                  child: widget.body,
                ),
        ],
      ),
    );
  }
}
