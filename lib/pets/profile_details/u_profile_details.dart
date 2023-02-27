import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/m_pet_profile.dart';

Future<PetProfileDetails> fetchPetProfileDetailsTest() async {
  final response =
      await http.get(Uri.parse('http://localhost:3000/pet/getPet/1'));

  if (response.statusCode == 200) {
    return PetProfileDetails.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load PetProfileDetails');
  }
}
