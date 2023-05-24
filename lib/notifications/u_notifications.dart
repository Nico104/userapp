import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:userapp/network_globals.dart';
import '../../../auth/u_auth.dart';

import 'model/m_notification.dart';

Future<List<Notification>> getUserNotifications() async {
  Uri url = Uri.parse('$baseURL/notification/getUserNotifications');
  String? token = await getIdToken();

  final response = await http.get(
    url,
    headers: {
      // 'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
  );

  if (response.statusCode == 200) {
    //Since this function is only called in NotificationPage when loaded the User has seen all Notifications
    await seenAllUserNotifications();

    return (jsonDecode(response.body) as List)
        .map((t) => Notification.fromJson(t))
        .toList();
  } else {
    throw Exception('Failed to load User Notifications');
  }
}

Future<int> getUnseenUserNotificationsCount() async {
  Uri url = Uri.parse('$baseURL/notification/getUnseenUserNotificationsCount');
  String? token = await getIdToken();

  final response = await http.get(
    url,
    headers: {
      // 'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
  );

  if (response.statusCode == 200) {
    return int.parse(response.body);
  } else {
    throw Exception('Failed to load User Notifications');
  }
}

//Seen Notification - meaning when he saw that there is one in the notificatrion page - he doesnt necesserally need to read it yet

Future<Notification> seenNotification({required int noticicationId}) async {
  Uri url = Uri.parse('$baseURL/notification/seenNotification');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode({
      'notificationId': noticicationId,
    }),
  );

  if (response.statusCode == 201) {
    return Notification.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to seen Notification');
  }
}

Future<Notification> unseeNotification({required int noticicationId}) async {
  Uri url = Uri.parse('$baseURL/notification/unseeNotification');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode({
      'notificationId': noticicationId,
    }),
  );

  if (response.statusCode == 201) {
    return Notification.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to unseen Notification');
  }
}

Future<void> seenAllUserNotifications() async {
  Uri url = Uri.parse('$baseURL/notification/seenAllUserNotifications');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
  );

  if (response.statusCode == 201) {
    return;
  } else {
    throw Exception('Failed to seen all Notifications');
  }
}

//Read Notification

Future<Notification> readNotification({required int noticicationId}) async {
  Uri url = Uri.parse('$baseURL/notification/readNotification');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode({
      'notificationId': noticicationId,
    }),
  );

  if (response.statusCode == 201) {
    return Notification.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to read Notification');
  }
}

Future<void> readAllUserNotifications() async {
  Uri url = Uri.parse('$baseURL/notification/readAllUserNotifications');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
  );

  if (response.statusCode == 201) {
    return;
  } else {
    throw Exception('Failed to read all Notifications');
  }
}

Future<void> deleteNotification(Notification notification) async {
  Uri url = Uri.parse('$baseURL/notification/deleteNotification');
  String? token = await getIdToken();

  final response = await http.delete(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode(notification.toJson()),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to delete Notification.');
  }
}
