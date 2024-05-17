import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:userapp/feature/pets/profile_details/models/m_notification_settings.dart';

import '../../../general/network_globals.dart';
import '../../auth/u_auth.dart';

Future<NotificationSettings> getNotificationSettings() async {
  Uri url = Uri.parse('$baseURL/user/getNotificationSettings');
  String? token = await getIdToken();

  final response = await http.get(
    url,
    headers: {
      // 'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
  );

  print("Body. " + response.body);

  if (response.statusCode == 200) {
    return NotificationSettings.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to get NotificationSettings');
  }
}

Future<void> updateNotificationSettings(
    {required NotificationSettings notificationSettings}) async {
  Uri url = Uri.parse('$baseURL/user/updateNotificationSettings');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode(notificationSettings.toJson()),
  );

  if (response.statusCode == 201) {
    return;
  } else {
    throw Exception('Failed to seen Notification');
  }
}
