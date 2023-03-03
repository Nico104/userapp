import 'package:flutter/material.dart';

import '../chip_style.dart';
import '../count_style.dart';
import '../tab_item.dart';
import '../widgets/build_icon.dart';
import '../widgets/hexagon/hexagon.dart';
import '../widgets/inspired/inspired.dart';
import '../widgets/inspired/transition_container.dart';

class BottomBarInspiredInside extends StatefulWidget {
  final List<TabItem> items;
  final double? height;
  final Color backgroundColor;
  final double? elevation;
  final bool fixed;
  final int indexSelected;
  final Function(int index)? onTap;
  final Color color;
  final Color colorSelected;
  final double iconSize;
  final double activeIconSize;
  final TextStyle? titleStyle;
  final CountStyle? countStyle;
  final ChipStyle? chipStyle;
  final ItemStyle? itemStyle;
  final bool animated;
  final bool isAnimated;
  final Duration? duration;
  final Curve? curve;
  final double? sizeInside;
  final double? padTop;
  final double? padbottom;
  final double? pad;
  final double? radius;
  final int? fixedIndex;
  final double notchBorderWidth;
  final Color notchBorderColor;
  final double notchTopMargin;
  final double borderWidth;
  final Color borderColor;
  final double? curveSize;
  const BottomBarInspiredInside({
    Key? key,
    required this.items,
    required this.backgroundColor,
    required this.color,
    required this.colorSelected,
    this.height = 40,
    this.elevation,
    this.fixed = false,
    this.indexSelected = 0,
    this.onTap,
    this.iconSize = 22,
    this.activeIconSize = 22,
    this.titleStyle,
    this.countStyle,
    this.chipStyle,
    this.itemStyle,
    this.animated = true,
    this.isAnimated = true,
    this.duration,
    this.curve,
    this.sizeInside = 48,
    this.padTop = 12,
    this.padbottom = 12,
    this.pad = 4,
    this.radius = 0,
    this.fixedIndex = 0,
    this.notchBorderColor = Colors.transparent,
    this.notchBorderWidth = 1,
    this.notchTopMargin = 0,
    this.borderWidth = 0,
    this.borderColor = Colors.transparent,
    this.curveSize,
  }) : super(key: key);

  @override
  BottomBarInspiredInsideState createState() => BottomBarInspiredInsideState();
}

class BottomBarInspiredInsideState extends State<BottomBarInspiredInside> {
  @override
  Widget build(BuildContext context) {
    return Inspired(
      height: widget.height!,
      count: widget.items.length,
      background: widget.backgroundColor,
      fixed: widget.fixed,
      elevation: widget.elevation,
      animated: widget.animated,
      isAnimated: widget.isAnimated,
      pad: widget.pad,
      padTop: widget.padTop,
      padbottom: widget.padbottom,
      fixedIndex: widget.fixedIndex,
      radius: widget.radius,
      itemBuilder: (_, int index, bool active) => buildItem(
        context,
        item: widget.items[index],
        index: index,
        isSelected: index == widget.indexSelected,
      ),
      initialActive: widget.indexSelected,
      iconChip: (int index) => widget.items[index].icon,
      onTap: widget.onTap,
      chipStyle: widget.chipStyle,
      itemStyle: widget.itemStyle,
      borderWidth: widget.borderWidth,
      borderColor: widget.borderColor,
      curveSize: widget.curveSize,
    );
  }

  Widget buildItem(
    BuildContext context, {
    required TabItem item,
    required int index,
    bool isSelected = false,
  }) {
    Color itemColor() {
      if (widget.fixed) {
        return isSelected ? widget.chipStyle!.background! : widget.color;
      }
      return isSelected ? widget.colorSelected : widget.color;
    }

    if (widget.fixed ? widget.fixedIndex == index : isSelected) {
      if (widget.animated) {
        return TransitionContainer.flip(
          data: index,
          duration: widget.duration ?? const Duration(milliseconds: 350),
          height: 80,
          curve: widget.curve ?? Curves.easeInOutCubic,
          bottomChild: buildContentItem(
              item, itemColor(), widget.activeIconSize, widget.sizeInside!),
        );
      }
      return buildContentItem(
          item, itemColor(), widget.activeIconSize, widget.sizeInside!);
    }
    return Container(
      padding: EdgeInsets.only(bottom: widget.padbottom!, top: widget.padTop!),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BuildIcon(
            item: item,
            iconColor: itemColor(),
            iconSize: widget.iconSize,
            countStyle: widget.countStyle,
          ),
          if (item.title is String && item.title != '') ...[
            SizedBox(height: widget.pad),
            Text(
              item.title!,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.merge(widget.titleStyle)
                  .copyWith(color: itemColor()),
              textAlign: TextAlign.center,
            )
          ],
        ],
      ),
    );
  }

  Widget buildContentItem(
      TabItem item, Color itemColor, double iconSize, double sizeInside) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.itemStyle == ItemStyle.circle)
          Container(
            margin: EdgeInsets.only(top: widget.notchTopMargin),
            width: sizeInside,
            height: sizeInside,
            decoration: BoxDecoration(
                color: widget.chipStyle?.background!,
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.notchBorderColor,
                  width: widget.notchBorderWidth,
                )),
            alignment: Alignment.center,
            child: BuildIcon(
              item: item,
              iconColor: widget.fixed ? widget.colorSelected : itemColor,
              iconSize: iconSize,
              countStyle: widget.countStyle,
            ),
          ),
        if (widget.itemStyle == ItemStyle.hexagon)
          HexagonWidget(
            width: sizeInside,
            height: sizeInside,
            cornerRadius: 8,
            color: widget.chipStyle?.background ?? Colors.blue,
            child: BuildIcon(
              item: item,
              iconColor: widget.fixed ? widget.colorSelected : itemColor,
              iconSize: iconSize,
              countStyle: widget.countStyle,
            ),
          ),
      ],
    );
  }
}
