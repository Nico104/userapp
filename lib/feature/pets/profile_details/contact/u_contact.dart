import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:userapp/general/network_globals.dart';
import 'package:userapp/feature/pets/profile_details/models/m_contact.dart';
import 'package:userapp/feature/pets/profile_details/models/m_phone_number.dart';
import '../../../auth/u_auth.dart';
import 'package:http_parser/http_parser.dart';

Future<List<Contact>> fetchUserContracts() async {
  Uri url = Uri.parse('$baseURL/contact/getUserContacts');
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
    return (jsonDecode(response.body) as List)
        .map((t) => Contact.fromJson(t))
        .toList();
  } else {
    throw Exception('Failed to load User Contracts');
  }
}

Future<List<Contact>> fetchPetContracts(int petProfileId) async {
  Uri url = Uri.parse('$baseURL/contact/getPetContacts/$petProfileId');
  String? token = await getIdToken();

  final response = await http.get(
    url,
    headers: {
      // 'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
  );

  print(response.statusCode);

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((t) => Contact.fromJson(t))
        .toList();
  } else {
    throw Exception('Failed to load Pet Contracts');
  }
}

Future<Contact> getContact(int contactId) async {
  Uri url = Uri.parse('$baseURL/contact/getContact/$contactId');
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
    return Contact.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Contract');
  }
}

Future<Contact> createNewContact({required String contactName}) async {
  Uri url = Uri.parse('$baseURL/contact/createContact');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode({
      'contact_name': contactName,
    }),
  );

  if (response.statusCode == 201) {
    return Contact.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create new Contact.');
  }
}

Future<Contact> connectContactToPet({
  required int contactId,
  required int petProfileId,
}) async {
  Uri url = Uri.parse('$baseURL/contact/connectContactToPet');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode({
      'pet_profile_id': petProfileId,
      'contact_id': contactId,
    }),
  );

  if (response.statusCode == 201) {
    return Contact.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to connect Contact.');
  }
}

Future<Contact> disconnectContactFromPet({
  required int contactId,
  required int petProfileId,
}) async {
  Uri url = Uri.parse('$baseURL/contact/disconnectContactFromPet');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode({
      'pet_profile_id': petProfileId,
      'contact_id': contactId,
    }),
  );

  if (response.statusCode == 201) {
    return Contact.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to disconnect Contact.');
  }
}

Future<Contact> updateContact(Contact contact) async {
  Uri url = Uri.parse('$baseURL/contact/updateContact');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode(contact.toJson()),
  );

  print(response.statusCode);

  if (response.statusCode == 201) {
    return Contact.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update Contact.');
  }
}

Future<void> deleteContact(Contact contact) async {
  Uri url = Uri.parse('$baseURL/contact/deleteContact');
  String? token = await getIdToken();

  final response = await http.delete(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode(contact.toJson()),
  );

  print(response.statusCode);

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to delete Contact.');
  }
}

//Phone Number
Future<PhoneNumber> updatePhoneNumber(PhoneNumber phoneNumber) async {
  Uri url = Uri.parse('$baseURL/contact/updatePhoneNumber');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode(phoneNumber.toJson()),
  );

  print(response.body);

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return PhoneNumber.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception(
        'Failed to update Phone Number with phoneNumberId ${phoneNumber.phoneNumberId}.');
  }
}

Future<PhoneNumber> createPhoneNumber(
  int contactId,
  String countryKey,
  String phoneNumber,
) async {
  Uri url = Uri.parse('$baseURL/contact/createPhoneNumber');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode({
      'contact_id': contactId,
      'country_key': countryKey,
      'phone_number': phoneNumber,
    }),
  );

  print(response.body);

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return PhoneNumber.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create Phone Number with  $phoneNumber.');
  }
}

Future<void> deletePhoneNumber(PhoneNumber phoneNumber) async {
  Uri url = Uri.parse('$baseURL/contact/deletePhoneNumber');
  String? token = await getIdToken();

  final response = await http.delete(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode(phoneNumber.toJson()),
  );

  print(response.statusCode);

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to delete Description.');
  }
}

//Languages Spoken
Future<void> connectLanguageSpoken(int contactId, String languageKey) async {
  Uri url = Uri.parse('$baseURL/contact/connectLanguageSpoken');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode(
      {
        "contactId": contactId,
        "languageKey": languageKey,
      },
    ),
  );

  if (response.statusCode == 201) {
  } else {
    throw Exception('Failed to connectLanguageSpoken.');
  }
}

Future<void> disconnectLanguageSpoken(int contactId, String languageKey) async {
  Uri url = Uri.parse('$baseURL/contact/disconnectLanguageSpoken');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode(
      {
        "contactId": contactId,
        "languageKey": languageKey,
      },
    ),
  );

  if (response.statusCode == 201) {
  } else {
    throw Exception('Failed to disconnectLanguageSpoken.');
  }
}

//Contact Description

// Future<List<ContactDescription>> fetchAvailableContactDescription() async {
//   Uri url = Uri.parse('$baseURL/contact/getUserContactDescriptions');
//   String? token = await getIdToken();

//   final response = await http.get(
//     url,
//     headers: {
//       // 'Content-Type': 'application/json; charset=UTF-8',
//       'Accept': 'application/json',
//       'Authorization': '$token',
//     },
//   );

//   print(response.statusCode);

//   if (response.statusCode == 200) {
//     return (jsonDecode(response.body) as List)
//         .map((t) => ContactDescription.fromJson(t))
//         .toList();
//   } else {
//     throw Exception('Failed to load AvailableContactDescription');
//   }
// }

// Future<void> connectContactDescription(
//   int contactId,
//   int contactDescriptionId,
// ) async {
//   Uri url = Uri.parse('$baseURL/contact/connectContactDescription');
//   String? token = await getIdToken();

//   final response = await http.post(
//     url,
//     headers: {
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Accept': 'application/json',
//       'Authorization': '$token',
//     },
//     body: jsonEncode({
//       'contact_id': contactId,
//       'contact_description_id': contactDescriptionId,
//     }),
//   );

//   print(response.body);

//   if (response.statusCode == 201) {
//     // return ContactDescription.fromJson(json.decode(response.body));
//   } else {
//     throw Exception('Failed to connect ContactDescription.');
//   }
// }

// Future<void> disconnectContactDescription(
//   int contactId,
// ) async {
//   Uri url = Uri.parse('$baseURL/contact/disconnectContactDescription');
//   String? token = await getIdToken();

//   final response = await http.post(
//     url,
//     headers: {
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Accept': 'application/json',
//       'Authorization': '$token',
//     },
//     body: jsonEncode({
//       'contact_id': contactId,
//     }),
//   );

//   print(response.body);

//   if (response.statusCode == 201) {
//     // return ContactDescription.fromJson(json.decode(response.body));
//   } else {
//     throw Exception('Failed to disconnect ContactDescription.');
//   }
// }

// Future<ContactDescription> createContactDescription(int contactId) async {
//   Uri url = Uri.parse('$baseURL/contact/createContactDescription');
//   String? token = await getIdToken();

//   final response = await http.post(
//     url,
//     headers: {
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Accept': 'application/json',
//       'Authorization': '$token',
//     },
//     body: jsonEncode({
//       'contact_id': contactId,
//       'contact_description_hex': getDefaultColor().toHexTriplet(),
//       'contact_description_label': getDefaultLabel(),
//     }),
//   );

//   print(response.statusCode);

//   if (response.statusCode == 201) {
//     return ContactDescription.fromJson(json.decode(response.body));
//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception('Failed to update ContactDescription.');
//   }
// }

// Future<ContactDescription> updateContactDescription(
//     ContactDescription contactDescription) async {
//   Uri url = Uri.parse('$baseURL/contact/updateContactDescription');
//   String? token = await getIdToken();

//   final response = await http.post(
//     url,
//     headers: {
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Accept': 'application/json',
//       'Authorization': '$token',
//     },
//     body: jsonEncode(contactDescription.toJson()),
//   );

//   print(response.statusCode);

//   if (response.statusCode == 201) {
//     return ContactDescription.fromJson(json.decode(response.body));
//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception('Failed to update ContactDescription.');
//   }
// }

// Future<ContactDescription> deleteContactDescription(
//     ContactDescription contactDescription) async {
//   Uri url = Uri.parse('$baseURL/contact/deleteContactDescription');
//   String? token = await getIdToken();

//   final response = await http.delete(
//     url,
//     headers: {
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Accept': 'application/json',
//       'Authorization': '$token',
//     },
//     body: jsonEncode(contactDescription.toJson()),
//   );

//   print(response.statusCode);

//   if (response.statusCode == 200) {
//     return ContactDescription.fromJson(json.decode(response.body));
//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception('Failed to delete ContactDescription.');
//   }
// }

// bool isContactDescriptionSelected(
//     Contact contact, ContactDescription contactDescription) {
//   if (contact.contactDescription != null) {
//     if (contact.contactDescription!.contactDescriptionId ==
//         contactDescription.contactDescriptionId) {
//       return true;
//     }
//   }

//   return false;
// }

//Contact Picture
Future<void> uploadContactPicture(
  int contactId,
  Uint8List picture,
  Function() callback,
) async {
  var url = Uri.parse('$baseURL/contact/uploadContactPicture/$contactId');
  // print("URL: " + url.toString());
  String? token = await getIdToken();

  var request = http.MultipartRequest('POST', url);

  request.headers['Authorization'] = '$token';

  request.files.add(http.MultipartFile.fromBytes('picture', picture,
      filename: "thumbnailname", contentType: MediaType('image', 'png')));

  await request.send().then((result) async {
    http.Response.fromStream(result).then((response) {
      if (response.statusCode == 201) {
        print("Uploaded! ");
      }
    });
  }).catchError((err) {
    print('error : $err');
  }).whenComplete(() {
    print("upload fertig1");
  });
  callback.call();
}

Future<void> deleteContactPicture(
  int contactId,
  String contactPictureLink,
) async {
  Uri url = Uri.parse('$baseURL/contact/deleteContactPicture');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: json.encode({
      "contact_id": contactId,
      "contact_picture_link": contactPictureLink,
    }),
  );

  print(response.statusCode);

  if (response.statusCode == 201) {
    return;
  } else {
    throw Exception('Failed to delete Contact Picture.');
  }
}
