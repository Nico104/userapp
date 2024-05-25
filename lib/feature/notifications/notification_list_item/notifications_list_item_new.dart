import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:timeago/timeago.dart' as timeago;
import '../../../general/widgets/custom_nico_modal.dart';
import '../../pets/profile_details/d_confirm_delete.dart';
import '../../../general/utils_custom_icons/custom_icons_icons.dart';
import '../model/m_notification.dart' as models;
import '../u_notifications.dart';

class NotificationListItemNew extends StatefulWidget {
  const NotificationListItemNew(
      {super.key, required this.notification, required this.reload});

  final models.Notification notification;

  final VoidCallback reload;

  @override
  State<NotificationListItemNew> createState() =>
      _NotificationListItemNewState();
}

class _NotificationListItemNewState extends State<NotificationListItemNew> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo.shade50,
      padding: const EdgeInsets.all(16),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade100,
                  ),
                  padding: const EdgeInsets.all(8),
                  //Put notification type specific image, maybe they get even send with the image itself
                  child: const Icon(
                    Icons.adf_scanner,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.indigo,
                  ),
                  width: 12,
                  height: 12,
                ),
              ],
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
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: Colors.indigo.shade400),
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
    showCustomNicoModalBottomSheet(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.check),
            title: const Text("notificationListItem_markAsRead").tr(),
            onTap: () {
              Navigator.pop(context);
              readNotification(
                noticicationId: widget.notification.notificationId,
              ).then((value) => widget.reload());
            },
          ),
          ListTile(
            leading: const Icon(CustomIcons.delete),
            title: const Text("notificationListItem_deleteNotification").tr(),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (_) => ConfirmDeleteDialog(
                  label: "notificationListItem_notification".tr(),
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
  }
}
