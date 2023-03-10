import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:userapp/language/m_language.dart';
import 'package:userapp/network_globals.dart';
import 'package:userapp/pets/profile_details/models/m_tag.dart';

import '../auth/u_auth.dart';
import 'profile_details/models/m_pet_profile.dart';

Future<List<PetProfileDetails>> fetchUserPets() async {
  Uri url = Uri.parse('$baseURL/pet/getUserPets');
  String? token = await getToken();

  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  });

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((t) => PetProfileDetails.fromJson(t))
        .toList();
  } else {
    throw Exception('Failed to load PetProfileDetails');
  }
}

Future<List<Language>> fetchAvailableLanguages() async {
  final response = await http.get(Uri.parse('$baseURL/pet/getLanguages'));

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((t) => Language.fromJson(t))
        .toList();
  } else {
    throw Exception('Failed to load PetProfileDetails');
  }
}

Future<List<Tag>> fetchUserTags() async {
  Uri url = Uri.parse('$baseURL/tag/getUserTags');
  String? token = await getToken();

  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  });

  if (response.statusCode == 200) {
    List<Tag> tags = (jsonDecode(response.body) as List)
        .map((t) => Tag.fromJson(t))
        .toList();
    //Show Tags without Profile first
    tags.sort((a, b) => a.petProfileId == null ? 0 : 1);
    return tags;
  } else {
    throw Exception('Failed to load Usertags');
  }
}

///Return true if assign was successfull, false if not
Future<bool> assignTagToUser(String activationCode) async {
  Uri url = Uri.parse('$baseURL/tag/assignTagToUser');
  String? token = await getToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({"activationCode": activationCode}),
  );

  if (response.statusCode == 201) {
    if (response.body.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } else {
    throw Exception('Failed to assignTagToUser');
  }
}
