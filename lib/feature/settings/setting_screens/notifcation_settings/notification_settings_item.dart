import 'package:flutter/material.dart';
import 'package:userapp/general/utils_theme/custom_colors.dart';

class NotificationSettingsItem extends StatelessWidget {
  const NotificationSettingsItem({
    super.key,
    required this.label,
    this.description,
    required this.value,
    required this.setValue,
  });

  final String label;
  final String? description;

  final bool value;
  final Function(bool) setValue;

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
                label,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              description != null
                  ? Flexible(
                      child: Text(
                        description ?? "",
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
            value: value,
            activeColor: getCustomColors(context).accentHighContrast,
            inactiveTrackColor: getCustomColors(context).lightBorder,
            onChanged: (bool value) {
              // setState(() {
              //   widget.value = value;
              // });
              setValue(value);
            },
          ),
        ),
      ],
    );
  }
}
