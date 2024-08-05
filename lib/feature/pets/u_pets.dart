import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:userapp/feature/pets/profile_details/models/m_pet_picture.dart';
import 'package:userapp/feature/pets/profile_details/models/m_social_media.dart';
import 'package:userapp/general/network_globals.dart';
import 'package:userapp/feature/pets/profile_details/models/m_document.dart';
import 'package:userapp/feature/pets/profile_details/models/m_scan.dart';

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

// Future<List<Country>> fetchAvailableCountries() async {
//   final response = await http.get(Uri.parse('$baseURL/pet/getCountries'));

//   if (response.statusCode == 200) {
//     return (jsonDecode(response.body) as List)
//         .map((t) => Country.fromJson(t))
//         .toList();
//   } else {
//     throw Exception('Failed to load Countries');
//   }
// }

Future<List<Country>> fetchAvailableCountriesLocal() async {
  // final response = await http.get(Uri.parse('$baseURL/pet/getCountries'));
  final String response =
      await rootBundle.loadString('assets/countries/countries.json');

  return (jsonDecode(response) as List)
      .map((t) => Country.fromJson(t))
      .toList();
}

Future<List<SocialMedia>> fetchAvailableSocialMedias() async {
  final response =
      await http.get(Uri.parse('$baseURL/contact/getSocialMedias'));

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((t) => SocialMedia.fromJson(t))
        .toList();
  } else {
    throw Exception('Failed to load Languages');
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

Future<Document> getDocument(int documentId) async {
  Uri url = Uri.parse('$baseURL/pet/getDocument/$documentId');
  String? token = await getIdToken();

  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': '$token',
  });

  if (response.statusCode == 200) {
    return Document.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load getDocument');
  }
}

Future<List<PetPicture>> getPetPictures(int petProfileId) async {
  Uri url = Uri.parse('$baseURL/pet/getPetPictures/$petProfileId');
  String? token = await getIdToken();

  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': '$token',
  });

  // print(response.body);
  // print("o yeah");

  if (response.statusCode == 200) {
    List<PetPicture> list = (jsonDecode(response.body) as List)
        .map((t) => PetPicture.fromJson(t))
        .toList();
    return list;
  } else {
    throw Exception('Failed to load PetPictures');
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
