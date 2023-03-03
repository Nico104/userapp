import 'dart:convert';
import 'package:http/http.dart' as http;

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
