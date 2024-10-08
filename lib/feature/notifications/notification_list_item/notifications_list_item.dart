import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import 'package:userapp/feature/notifications/notification_list_item/location_notification.dart';
import '../../../general/widgets/custom_nico_modal.dart';
import '../../pets/profile_details/d_confirm_delete.dart';
import '../../../general/utils_custom_icons/custom_icons_icons.dart';
import '../model/m_notification.dart' as models;
import '../u_notifications.dart';

class NotificationListItem extends StatefulWidget {
  const NotificationListItem(
      {super.key,
      required this.notification,
      required this.reload,
      required this.newNotification});

  final models.Notification notification;

  final VoidCallback reload;

  final bool newNotification;

  @override
  State<NotificationListItem> createState() => _NotificationListItemState();
}

Widget getIconFromType(String type) {
  switch (type) {
    case 'scan':
      return const Icon(CustomIcons.qr_code_9, size: 32);
    case 'contact':
      return const Icon(Icons.person_rounded);
    case 'location':
      return const Icon(Icons.location_on_outlined, size: 32);
    default:
      return const Icon(Icons.notifications_outlined, size: 32);
  }
}

class _NotificationListItemState extends State<NotificationListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.newNotification
          ? Colors.indigo.shade50
          : Theme.of(context).primaryColor,
      padding: const EdgeInsets.all(16),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.newNotification
                      ? Colors.grey.shade100
                      : Colors.grey.shade200,
                ),
                padding: const EdgeInsets.all(8),
                //Put notification type specific image, maybe they get even send with the image itself
                // child: const Icon(
                //   Icons.notifi,
                //   size: 32,
                // ),
                child: getIconFromType(widget.notification.notificationType)),
            const Spacer(flex: 2),
            const SizedBox(width: 8),
            SizedBox(
              width: 70.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.notification.notificationTitle,
                    style: Theme.of(context).textTheme.labelMedium,
                    softWrap: true,
                  ),
                  Text(
                    widget.notification.notificationBody,
                    style: Theme.of(context).textTheme.labelSmall,
                    softWrap: true,
                  ),
                  Text(
                    // https://pub.dev/packages/timeago for other languages
                    timeago.format(widget.notification.creationDateTime),
                    style: Theme.of(context).textTheme.labelSmall,
                    softWrap: true,
                  ),
                ],
              ),
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
          (widget.notification.notificationType == 'location')
              ? ListTile(
                  leading: const Icon(Icons.location_on_outlined),
                  title: const Text("notificationListItem_showLocation").tr(),
                  onTap: () {
                    Navigator.pop(context);
                    launchUrl(
                      Uri.parse(generateMapsLink(
                          widget.notification.notificationBody)),
                    );
                  },
                )
              : const SizedBox.shrink(),
          widget.newNotification
              ? ListTile(
                  leading: const Icon(Icons.check),
                  title: const Text("notificationListItem_markAsRead").tr(),
                  onTap: () {
                    Navigator.pop(context);
                    readNotification(
                      noticicationId: widget.notification.notificationId,
                    ).then((value) => widget.reload());
                  },
                )
              : ListTile(
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
