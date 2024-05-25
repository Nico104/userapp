import 'package:flutter/material.dart';
import 'package:userapp/feature/notifications/u_notifications.dart';
import 'package:userapp/general/utils_theme/custom_colors.dart';

import '../../general/utils_general.dart';
import '../../general/widgets/future_error_widget.dart';
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
            readAllUserNotifications();
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
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              );
            }
          } else if (snapshot.hasError) {
            WidgetsBinding.instance.addPostFrameCallback((_) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FutureErrorWidget(),
                  ),
                ).then((value) => setState(
                      () {},
                    )));
            return const SizedBox.shrink();
          }
          return widget.icon;
        },
      ),
    );
  }
}
