import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/notifications/u_notifications.dart';

import 'model/m_notification.dart' as models;
import 'notification_list_item/notifications_list_item.dart';
import 'notification_list_item/notifications_list_item_new.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  late List<models.Notification> _notificationsList;
  late Future<void> _initNotifications;

  Future<void> _initNotifics() async {
    final List<models.Notification> notifications =
        await getUserNotifications();
    _notificationsList = notifications;
  }

  Future<void> _refreshNotifications() async {
    final List<models.Notification> notifications =
        await getUserNotifications();
    setState(() {
      _notificationsList = notifications;
    });
  }

  @override
  void initState() {
    super.initState();
    _initNotifications = _initNotifics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("appBarNotifications".tr()),
      ),
      body: FutureBuilder(
        future: _initNotifications,
        builder: (BuildContext context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              {
                return const Center(
                  child: Text('Loading...'),
                );
              }
            case ConnectionState.done:
              {
                return RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: _refreshNotifications,
                  child: (_notificationsList.isNotEmpty)
                      ? ListView.builder(
                          itemCount: _notificationsList.length,
                          itemBuilder: (BuildContext context, index) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                index == 0
                                    ? Divider(
                                        color: Colors.grey.shade100,
                                        thickness: 5,
                                        height: 5,
                                      )
                                    : const SizedBox(),
                                _notificationsList[index].read
                                    ? NotificationListItem(
                                        notification: _notificationsList[index],
                                        reload: _refreshNotifications,
                                        newNotification: false,
                                      )
                                    // : NotificationListItemNew(
                                    //     notification: _notificationsList[index],
                                    //     reload: _refreshNotifications,
                                    //   ),
                                    : NotificationListItem(
                                        notification: _notificationsList[index],
                                        reload: _refreshNotifications,
                                        newNotification: true,
                                      ),
                                index < _notificationsList.length - 1
                                    ? Divider(
                                        color: Colors.grey.shade200,
                                        height: 1,
                                        thickness: 1,
                                      )
                                    : const SizedBox(),
                              ],
                            );
                          },
                        )
                      : Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 30.w,
                                child:
                                    Image.asset("assets/tmp/notifications.png"),
                              ),
                              const SizedBox(height: 32),
                              Text(
                                "No Notifications yet",
                                style: Theme.of(context).textTheme.labelLarge,
                              )
                            ],
                          ),
                        ),
                );
              }
          }
        },
      ),
    );
  }
}
