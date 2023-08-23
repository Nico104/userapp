import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:userapp/general/network_globals.dart';
import 'package:userapp/feature/pets/profile_details/models/m_document.dart';
import 'package:userapp/feature/pets/profile_details/models/m_scan.dart';
import 'package:userapp/feature/pets/profile_details/models/m_tag.dart';

import '../auth/u_auth.dart';
import '../language/m_language.dart';
import 'profile_details/models/m_pet_profile.dart';

Future<List<PetProfileDetails>> fetchUserPets() async {
  Uri url = Uri.parse('$baseURL/pet/getUserPets');
  String? token = await getIdToken();

  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': '$token',
  });

  print(response.body);

  if (response.statusCode == 200) {
    List<PetProfileDetails> list = (jsonDecode(response.body) as List)
        .map((t) => PetProfileDetails.fromJson(t))
        .toList();
    // list.forEach((element) {
    //   element.petDocuments.forEach((element) {
    //     print(element.documentName);
    //   });
    // });
    return list;
  } else {
    throw Exception('Failed to load PetProfileDetails');
  }
}

Future<List<PetProfileDetails>> getPetsFromContact(int contactId) async {
  Uri url = Uri.parse('$baseURL/pet/getPetsFromContact/$contactId');
  String? token = await getIdToken();

  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': '$token',
  });

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((t) => PetProfileDetails.fromJson(t))
        .toList();
  } else {
    throw Exception('Failed to load PetProfileDetails From Contact');
  }
}

Future<List<Language>> fetchAvailableLanguages() async {
  final response = await http.get(Uri.parse('$baseURL/pet/getLanguages'));

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((t) => Language.fromJson(t))
        .toList();
  } else {
    throw Exception('Failed to load Languages');
  }
}

Future<List<Country>> fetchAvailableCountries() async {
  final response = await http.get(Uri.parse('$baseURL/pet/getCountries'));

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((t) => Country.fromJson(t))
        .toList();
  } else {
    throw Exception('Failed to load Countries');
  }
}

Future<PetProfileDetails> getPet(int petProfileId) async {
  Uri url = Uri.parse('$baseURL/pet/getPet/$petProfileId');
  // String? token = await getIdToken();

  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    // 'Authorization': '$token',
  });

  print(response.body);

  if (response.statusCode == 200) {
    return PetProfileDetails.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Pet');
  }
}

Future<List<Document>> getPetDocuments(int petProfileId) async {
  Uri url = Uri.parse('$baseURL/pet/getPetDocuments/$petProfileId');
  String? token = await getIdToken();

  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': '$token',
  });

  // print(response.body);
  // print("o yeah");

  if (response.statusCode == 200) {
    List<Document> list = (jsonDecode(response.body) as List)
        .map((t) => Document.fromJson(t))
        .toList();
    return list;
  } else {
    throw Exception('Failed to load PetProfileDetails');
  }
}

Future<List<Scan>> getPetScans(int petProfileId) async {
  Uri url = Uri.parse('$baseURL/scan/getProfileScans/$petProfileId');
  String? token = await getIdToken();

  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': '$token',
  });

  // print(response.body);
  // print("o yeah");

  if (response.statusCode == 200) {
    List<Scan> list = (jsonDecode(response.body) as List)
        .map((t) => Scan.fromJson(t))
        .toList();
    return list;
  } else {
    throw Exception('Failed to load Scans');
  }
}
