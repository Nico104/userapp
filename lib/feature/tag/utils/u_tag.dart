import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:userapp/general/network_globals.dart';
import 'package:userapp/feature/pets/profile_details/models/m_tag.dart';

import '../../auth/u_auth.dart';

Future<List<Tag>> getUserTags() async {
  Uri url = Uri.parse('$baseURL/tag/getUserTags');
  String? token = await getIdToken();

  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': '$token',
  });

  if (response.statusCode == 200) {
    List<Tag> tags = (jsonDecode(response.body) as List)
        .map((t) => Tag.fromJson(t))
        .toList();
    //Show Tags without Profile first
    // tags.sort((a, b) => a.petProfileId == null ? 0 : 1);
    return tags;
  } else {
    throw Exception('Failed to load Usertags');
  }
}

Future<List<Tag>> getUserProfileTags(int petProfileId) async {
  Uri url =
      Uri.parse('$baseURL/tag/getUserProfileTags/${petProfileId.toString()}');
  String? token = await getIdToken();

  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': '$token',
  });

  if (response.statusCode == 200) {
    List<Tag> tags = (jsonDecode(response.body) as List)
        .map((t) => Tag.fromJson(t))
        .toList();
    //Show Tags without Profile first
    // tags.sort((a, b) => a.petProfileId == null ? 0 : 1);
    return tags;
  } else {
    throw Exception('Failed to load Usertags');
  }
}

///Return true if assign was successfull, false if not
Future<Tag> assignTagToUser(String activationCode) async {
  Uri url = Uri.parse('$baseURL/tag/assignTagToUser');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode({"activationCode": activationCode}),
  );

  print(response.body);

  if (response.statusCode == 201) {
    if (response.body.isNotEmpty) {
      return Tag.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to assignTagToUser2');
    }
  } else {
    throw Exception('Failed to assignTagToUser');
  }
}

Future<Tag> getTag(String tagId) async {
  Uri url = Uri.parse('$baseURL/tag/getTag/$tagId');
  String? token = await getIdToken();

  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': '$token',
  });

  if (response.statusCode == 200) {
    if (response.body.isNotEmpty) {
      return Tag.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Tag1');
    }
    // List<Tag> tags = (jsonDecode(response.body) as List)
    //     .map((t) => Tag.fromJson(t))
    //     .toList();
    // //Show Tags without Profile first
    // // tags.sort((a, b) => a.petProfileId == null ? 0 : 1);
    // return tags;
  } else {
    throw Exception('Failed to load Tags');
  }
}
