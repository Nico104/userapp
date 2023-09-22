import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:userapp/general/network_globals.dart';

import '../../../auth/u_auth.dart';

Future<bool> createContactUsMessage({
  required String categorie,
  required String text,
  required String declared_name,
  required String declared_email,
}) async {
  var url = Uri.parse('$baseURL/contactus/createContactUsMessage');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode({
      "categorie": categorie,
      "text": text,
      "declared_name": declared_name,
      "declared_email": declared_email,
    }),
  );

  print(response.statusCode);

  if (response.statusCode == 201) {
    return response.body == 'true';
  } else {
    throw Exception("Error sending Message");
  }
}
