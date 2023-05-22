import 'package:flutter/material.dart';
import 'package:userapp/notifications/u_notifications.dart';
import 'package:userapp/theme/custom_colors.dart';

import '../utils/util_methods.dart';
import 'notifications_page.dart';

class NotificationsIcon extends StatefulWidget {
  const NotificationsIcon({
    super.key,
    required this.icon,
  });

  final Widget icon;

  @override
  State<NotificationsIcon> createState() => _NotificationsIconState();
}

class _NotificationsIconState extends State<NotificationsIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigatePerSlide(
          context,
          const NotificationPage(),
          //? callback needed?
          callback: () {
            setState(() {});
          },
        );
      },
      child: FutureBuilder<int>(
        future: getUnseenUserNotificationsCount(),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data! > 0) {
              return Stack(
                alignment: Alignment.topRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6, right: 4),
                    child: widget.icon,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: getCustomColors(context).accent,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      snapshot.data!.toString(),
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              );
            }
          }
          return widget.icon;
        },
      ),
    );
  }
}
