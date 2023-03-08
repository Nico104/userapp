import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:userapp/language/m_language.dart';
import 'package:userapp/pets/profile_details/models/m_tag.dart';

import 'profile_details/models/m_pet_profile.dart';

Future<List<PetProfileDetails>> fetchUserPets() async {
  final response =
      await http.get(Uri.parse('http://localhost:3000/pet/getUserPets'));

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((t) => PetProfileDetails.fromJson(t))
        .toList();
  } else {
    throw Exception('Failed to load PetProfileDetails');
  }
}

Future<List<Language>> fetchAvailableLanguages() async {
  final response =
      await http.get(Uri.parse('http://localhost:3000/pet/getLanguages'));

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((t) => Language.fromJson(t))
        .toList();
  } else {
    throw Exception('Failed to load PetProfileDetails');
  }
}

Future<List<Tag>> fetchUserTags() async {
  final response =
      await http.get(Uri.parse('http://localhost:3000/pet/getUserTags'));

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((t) => Tag.fromJson(t))
        .toList();
  } else {
    throw Exception('Failed to load Usertags');
  }
}
