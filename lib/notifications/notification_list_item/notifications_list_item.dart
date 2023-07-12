import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:timeago/timeago.dart' as timeago;
import '../../pets/profile_details/d_confirm_delete.dart';
import '../../styles/custom_icons_icons.dart';
import '../model/m_notification.dart' as models;
import '../u_notifications.dart';

class NotificationListItem extends StatefulWidget {
  const NotificationListItem(
      {super.key, required this.notification, required this.reload});

  final models.Notification notification;

  final VoidCallback reload;

  @override
  State<NotificationListItem> createState() => _NotificationListItemState();
}

class _NotificationListItemState extends State<NotificationListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.all(16),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade200,
              ),
              padding: const EdgeInsets.all(8),
              //Put notification type specific image, maybe they get even send with the image itself
              child: const Icon(
                Icons.adf_scanner,
                size: 32,
              ),
            ),
            const Spacer(flex: 1),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.notification.notificationTitle,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Text(
                  widget.notification.notificationBody,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(
                  // https://pub.dev/packages/timeago for other languages
                  timeago.format(widget.notification.creationDateTime),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
            const Spacer(
              flex: 8,
            ),
            Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () => _showOptions(),
                  child: const Icon(
                    Icons.more_horiz,
                    size: 28,
                  ),
                ),
                const Spacer(flex: 5),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.visibility_off_outlined),
                title: Text("notificationMenuUnseeNotification".tr()),
                onTap: () {
                  Navigator.pop(context);
                  unseeNotification(
                    noticicationId: widget.notification.notificationId,
                  ).then((value) => widget.reload());
                },
              ),
              ListTile(
                leading: const Icon(CustomIcons.delete),
                title: Text("notificationMenuDeleteNotification".tr()),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (_) => const ConfirmDeleteDialog(
                      label: "Notification",
                    ),
                  ).then((value) {
                    if (value != null) {
                      if (value == true) {
                        deleteNotification(widget.notification)
                            .then((value) => widget.reload());
                      }
                    }
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
