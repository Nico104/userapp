import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:userapp/network_globals.dart';
import 'package:userapp/pet_color/hex_color.dart';
import 'package:userapp/pets/profile_details/models/m_contact.dart';
import 'package:userapp/pets/profile_details/models/m_contact_descripton.dart';
import 'package:userapp/pets/profile_details/models/m_phone_number.dart';
import '../../../auth/u_auth.dart';
import 'package:http_parser/http_parser.dart';

Future<List<Contact>> fetchPetContracts(int petProfileId) async {
  Uri url = Uri.parse('$baseURL/contact/getPetContacts/$petProfileId');
  String? token = await getToken();

  final response = await http.get(
    url,
    headers: {
      // 'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
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

Future<Contact> getPetContact(int contactId) async {
  Uri url = Uri.parse('$baseURL/contact/getContact/$contactId');
  String? token = await getToken();

  final response = await http.get(
    url,
    headers: {
      // 'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    return Contact.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Pet Contracts');
  }
}

Future<Contact> createNewPetContact(
    {required int petProfileId, required String contactName}) async {
  Uri url = Uri.parse('$baseURL/contact/createContact');
  String? token = await getToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
      'pet_profile_id': petProfileId,
      'contact_name': contactName,
    }),
  );

  print(response.statusCode);

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Contact.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create new Contact.');
  }
}

Future<Contact> updateContact(Contact contact) async {
  Uri url = Uri.parse('$baseURL/contact/updateContact');
  String? token = await getToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
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
  String? token = await getToken();

  final response = await http.delete(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
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
  String? token = await getToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
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
  String? token = await getToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
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
  String? token = await getToken();

  final response = await http.delete(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
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

//Contact Description

Future<List<ContactDescription>> fetchAvailableContactDescription() async {
  Uri url = Uri.parse('$baseURL/contact/getUserContactDescriptions');
  String? token = await getToken();

  final response = await http.get(
    url,
    headers: {
      // 'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  print(response.statusCode);

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((t) => ContactDescription.fromJson(t))
        .toList();
  } else {
    throw Exception('Failed to load AvailableContactDescription');
  }
}

Future<void> connectContactDescription(
  int contactId,
  int contactDescriptionId,
) async {
  Uri url = Uri.parse('$baseURL/contact/connectContactDescription');
  String? token = await getToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
      'contact_id': contactId,
      'contact_description_id': contactDescriptionId,
    }),
  );

  print(response.body);

  if (response.statusCode == 201) {
    // return ContactDescription.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to connect ContactDescription.');
  }
}

Future<void> disconnectContactDescription(
  int contactId,
) async {
  Uri url = Uri.parse('$baseURL/contact/disconnectContactDescription');
  String? token = await getToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
      'contact_id': contactId,
    }),
  );

  print(response.body);

  if (response.statusCode == 201) {
    // return ContactDescription.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to disconnect ContactDescription.');
  }
}

Future<ContactDescription> createContactDescription(int contactId) async {
  Uri url = Uri.parse('$baseURL/contact/createContactDescription');
  String? token = await getToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
      'contact_id': contactId,
      'contact_description_hex': getDefaultColor().toHexTriplet(),
      'contact_description_label': getDefaultLabel(),
    }),
  );

  print(response.statusCode);

  if (response.statusCode == 201) {
    return ContactDescription.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to update ContactDescription.');
  }
}

Future<ContactDescription> updateContactDescription(
    ContactDescription contactDescription) async {
  Uri url = Uri.parse('$baseURL/contact/updateContactDescription');
  String? token = await getToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(contactDescription.toJson()),
  );

  print(response.statusCode);

  if (response.statusCode == 201) {
    return ContactDescription.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to update ContactDescription.');
  }
}

Future<ContactDescription> deleteContactDescription(
    ContactDescription contactDescription) async {
  Uri url = Uri.parse('$baseURL/contact/deleteContactDescription');
  String? token = await getToken();

  final response = await http.delete(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(contactDescription.toJson()),
  );

  print(response.statusCode);

  if (response.statusCode == 200) {
    return ContactDescription.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to delete ContactDescription.');
  }
}

bool isContactDescriptionSelected(
    Contact contact, ContactDescription contactDescription) {
  if (contact.contactDescription != null) {
    if (contact.contactDescription!.contactDescriptionId ==
        contactDescription.contactDescriptionId) {
      return true;
    }
  }

  return false;
}

//Contact Picture
Future<void> uploadContactPicture(
  int contactId,
  Uint8List picture,
  Function() callback,
) async {
  var url = Uri.parse('$baseURL/contact/uploadContactPicture/$contactId');
  // print("URL: " + url.toString());
  String? token = await getToken();

  var request = http.MultipartRequest('POST', url);

  request.headers['Authorization'] = 'Bearer $token';

  request.files.add(http.MultipartFile.fromBytes('picture', picture,
      filename: "thumbnailname", contentType: MediaType('image', 'png')));

  await request.send().then((result) async {
    http.Response.fromStream(result).then((response) {
      if (response.statusCode == 201) {
        print("Uploaded! ");
      }
    });
  }).catchError((err) {
    print('error : ' + err.toString());
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
  String? token = await getToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
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
