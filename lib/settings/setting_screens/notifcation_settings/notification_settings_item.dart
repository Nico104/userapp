import 'package:flutter/material.dart';
import 'package:userapp/theme/custom_colors.dart';

class NotificationSettingsItem extends StatefulWidget {
  const NotificationSettingsItem({
    super.key,
    required this.label,
    this.description,
  });

  final String label;
  final String? description;

  @override
  State<NotificationSettingsItem> createState() =>
      _NotificationSettingsItemState();
}

class _NotificationSettingsItemState extends State<NotificationSettingsItem> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    //TODO get current Setting
    _value = true;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.label,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              widget.description != null
                  ? Flexible(
                      child: Text(
                        widget.description ?? "",
                        style: Theme.of(context).textTheme.labelSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        const SizedBox(width: 22),
        Theme(
          data: Theme.of(context).copyWith(useMaterial3: true),
          child: Switch(
            value: _value,
            activeColor: getCustomColors(context).accentDark,
            inactiveTrackColor: getCustomColors(context).lightBorder,
            onChanged: (bool value) {
              setState(() {
                _value = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
