import 'dart:convert';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:userapp/feature/pets/profile_details/models/m_behaviour_information.dart';
import 'package:userapp/feature/pets/profile_details/models/medical/m_medical_information.dart';
import 'package:userapp/general/network_globals.dart';
import 'package:userapp/feature/pets/profile_details/models/m_description.dart';
import 'package:userapp/feature/pets/profile_details/models/m_document.dart';
import 'package:userapp/feature/pets/profile_details/models/m_pet_picture.dart';

import '../../auth/u_auth.dart';
import 'c_pet_name.dart';
import 'models/m_pet_profile.dart';
import 'models/m_tag.dart';
import 'package:http_parser/http_parser.dart';

import 'models/medical/m_health_issue.dart';

//Pictures

Future<void> uploadPicture(
  int profileId,
  Uint8List picture,
  Function() callback,
) async {
  var url = Uri.parse('$baseURL/pet/uploadPicture/$profileId');
  print("URL: $url");
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

Future<void> deletePicture(PetPicture petPicture) async {
  Uri url = Uri.parse('$baseURL/pet/deletePicture');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: json.encode({
      "pet_picture_id": petPicture.petPictureId,
      "pet_picture_link": petPicture.petPictureLink,
      "profile_id": petPicture.petProfileId,
    }),
  );

  print(response.statusCode);

  if (response.statusCode == 201) {
    return;
  } else {
    throw Exception('Failed to delete Picture.');
  }
}

//Documents
Future<void> uploadDocuments(
  int profileId,
  Uint8List document,
  String documentName,
  String contentType,
  Function() callback,
) async {
  print("ID: " + profileId.toString());
  print("document: " + document.toString());
  print("documentName: " + documentName.toString());
  print("contentType: " + contentType.toString());

  var url = Uri.parse('$baseURL/pet/uploadDocument/$profileId');
  print("URL: $url");
  String? token = await getIdToken();

  var request = http.MultipartRequest('POST', url);

  final data = {
    'document_name': documentName,
    // 'document_type': documentType,
    'content_type': contentType,
  };

  request = jsonToFormData(request, data);

  // request.headers['X-Requested-With'] = "XMLHttpRequest";
  request.headers['Authorization'] = '$token';

  request.files.add(
      http.MultipartFile.fromBytes('document', document, filename: "document"));

  await request.send().then((result) async {
    http.Response.fromStream(result).then((response) {
      print(response.body);
      if (response.statusCode == 201) {
        print("Uploaded");
      }
    });
  }).catchError((err) {
    print('error : $err');
  }).whenComplete(() {
    print("upload fertig2");
  });
  callback.call();
}

Future<void> deleteDocument(Document petDocuemnt) async {
  Uri url = Uri.parse('$baseURL/pet/deleteDocument');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: json.encode({
      "pet_document_id": petDocuemnt.documentId,
      "pet_document_link": petDocuemnt.documentLink,
      "profile_id": petDocuemnt.petProfileId,
    }),
  );

  print(response.statusCode);

  if (response.statusCode == 201) {
    return;
  } else {
    throw Exception('Failed to delete Picture.');
  }
}

Future<Document> updateDocument({
  required int documentId,
  required String documentName,
  required String documentType,
}) async {
  Uri url = Uri.parse('$baseURL/pet/updateDocument');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode({
      "document_id": documentId,
      "document_name": documentName,
      "document_type": documentType,
    }),
  );

  print(response.body);

  if (response.statusCode == 201) {
    return Document.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update Document.');
  }
}

jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
  for (var key in data.keys) {
    request.fields[key] = data[key].toString();
  }
  return request;
}

Future<void> handleTagChange(
  List<Tag> newTags,
  List<Tag> oldTags,
  int profileId,
) async {
  for (Tag tag in disconnectableTags(newTags, oldTags)) {
    await disconnectTagFromPetProfile(profileId, tag.collarTagId);
  }
  for (Tag tag in connectableTags(newTags, oldTags)) {
    await connectTagFromPetProfile(profileId, tag.collarTagId);
  }
}

Future<PetProfileDetails> createNewPetProfile(String petName) async {
  print("yo");
  Uri url = Uri.parse('$baseURL/pet/createPet');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      // 'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: {
      'pet_name': petName,
      'pet_is_Lost': false.toString(),
    },
  );

  print(response.statusCode);

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return PetProfileDetails.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create new PetPofile.');
  }
}

Future<void> deletePetProfile(PetProfileDetails petProfileDetails) async {
  //Delete all Picture, Documents and Contacts (Probelms doing that from the Server)
  for (var element in petProfileDetails.petPictures) {
    await deletePicture(element);
  }
  for (var element in petProfileDetails.petDocuments) {
    await deleteDocument(element);
  }

  Uri url = Uri.parse('$baseURL/pet/deletePet');
  String? token = await getIdToken();

  final response = await http.delete(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode(petProfileDetails.toJson()),
  );

  print(response.statusCode);

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to delete PetProfile.');
  }
}

Future<PetProfileDetails> updatePetProfileCore(
    PetProfileDetails petProfileDetails) async {
  Uri url = Uri.parse('$baseURL/pet/updatePet');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode(petProfileDetails.toJson()),
  );

  print(response.body);

  if (response.statusCode == 201) {
    return PetProfileDetails.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update PetPofile.');
  }
}

//Phone Number
// Future<PhoneNumber> updatePhoneNumber(PhoneNumber phoneNumber) async {
//   Uri url = Uri.parse('$baseURL/pet/updatePhoneNumber');
//   String? token = await getIdToken();

//   final response = await http.post(
//     url,
//     headers: {
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Accept': 'application/json',
//       'Authorization': '$token',
//     },
//     body: jsonEncode(phoneNumber.toJson()),
//   );

//   print(response.body);

//   if (response.statusCode == 201) {
//     // If the server did return a 201 CREATED response,
//     // then parse the JSON.
//     return PhoneNumber.fromJson(json.decode(response.body));
//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception(
//         'Failed to update Phone Number with phoneNumberId ${phoneNumber.phoneNumberId}.');
//   }
// }

// Future<PhoneNumber> createPhoneNumber(
//   int petProfileId,
//   String countryKey,
//   String phoneNumber,
// ) async {
//   Uri url = Uri.parse('$baseURL/pet/createPhoneNumber');
//   String? token = await getIdToken();

//   final response = await http.post(
//     url,
//     headers: {
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Accept': 'application/json',
//       'Authorization': '$token',
//     },
//     body: jsonEncode({
//       'petProfile_id': petProfileId,
//       'country_key': countryKey,
//       'phone_number': phoneNumber,
//     }),
//   );

//   print(response.body);

//   if (response.statusCode == 201) {
//     // If the server did return a 201 CREATED response,
//     // then parse the JSON.
//     return PhoneNumber.fromJson(json.decode(response.body));
//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception('Failed to create Phone Number with  $phoneNumber.');
//   }
// }

// Future<void> deletePhoneNumber(PhoneNumber phoneNumber) async {
//   Uri url = Uri.parse('$baseURL/pet/deletePhoneNumber');
//   String? token = await getIdToken();

//   final response = await http.delete(
//     url,
//     headers: {
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Accept': 'application/json',
//       'Authorization': '$token',
//     },
//     body: jsonEncode(phoneNumber.toJson()),
//   );

//   print(response.statusCode);

//   if (response.statusCode == 200) {
//     // If the server did return a 201 CREATED response,
//     // then parse the JSON.
//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception('Failed to delete Description.');
//   }
// }

//Description
Future<void> upsertDescription(Description description) async {
  Uri url = Uri.parse('$baseURL/pet/upsertDescription');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode(description.toJson()),
  );

  print(response.body);

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to upsert Description.');
  }
}

Future<void> deleteDescription(
  Description description,
) async {
  Uri url = Uri.parse('$baseURL/pet/deleteDescription');
  String? token = await getIdToken();

  final response = await http.delete(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode(description.toJson()),
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

Future<void> updateContactVisibility({
  required int petProfileId,
  required bool contact_visbility,
}) async {
  Uri url = Uri.parse('$baseURL/pet/updateContactVisibility');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode({
      "contact_visbility": contact_visbility,
      "petProfileId": petProfileId,
    }),
  );

  print(response.body);

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to updateContactVisibility');
  }
}

// Future<void> upsertImportantInformation(
//     ImportantInformation importantInformation) async {
//   Uri url = Uri.parse('$baseURL/pet/upsertImportantInformation');
//   String? token = await getIdToken();

//   final response = await http.post(
//     url,
//     headers: {
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Accept': 'application/json',
//       'Authorization': '$token',
//     },
//     body: jsonEncode(importantInformation.toJson()),
//   );

//   print(response.body);

//   if (response.statusCode == 201) {
//     // If the server did return a 201 CREATED response,
//     // then parse the JSON.
//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception('Failed to upsert ImpInf.');
//   }
// }

// Future<void> deleteImportantInformation(
//     ImportantInformation importantInformation) async {
//   Uri url = Uri.parse('$baseURL/pet/deleteImportantInformation');
//   String? token = await getIdToken();

//   final response = await http.delete(
//     url,
//     headers: {
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Accept': 'application/json',
//       'Authorization': '$token',
//     },
//     body: jsonEncode(importantInformation.toJson()),
//   );

//   print(response.statusCode);

//   if (response.statusCode == 200) {
//     // If the server did return a 201 CREATED response,
//     // then parse the JSON.
//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception('Failed to delete Description.');
//   }
// }

Future<void> connectTagFromPetProfile(int profileId, String collarTagId) async {
  Uri url = Uri.parse('$baseURL/pet/connectTagFromPetProfile');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode({"profileId": profileId, "collarTagId": collarTagId}),
  );

  print(response.body);

  if (response.statusCode == 201) {
  } else {
    throw Exception('Failed to connectTagFromPetProfile.');
  }
}

Future<void> disconnectTagFromPetProfile(
    int profileId, String collarTagId) async {
  Uri url = Uri.parse('$baseURL/pet/disconnectTagFromPetProfile');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode({"profileId": profileId, "collarTagId": collarTagId}),
  );

  print(response.body);

  if (response.statusCode == 201) {
  } else {
    throw Exception('Failed to disconnectTagFromPetProfile.');
  }
}

///Return all Descriptions which are new or updated
List<Description> upsertableDescriptions(
    List<Description> newList, List<Description> oldList) {
  List<Description> list = List<Description>.empty(growable: true);

  for (Description item in newList) {
    bool addToList = true;
    for (Description oldItem in oldList) {
      if (item.text == oldItem.text &&
          item.language.languageKey == oldItem.language.languageKey) {
        addToList = false;
      }
    }
    if (addToList) {
      list.add(item);
    }
  }

  return list;
}

///Return all Descriptions which have been deleted
List<Description> deletableDescriptions(
    List<Description> newList, List<Description> oldList) {
  List<Description> list = List<Description>.empty(growable: true);

  for (Description oldItem in oldList) {
    bool addToList = true;
    for (Description item in newList) {
      if (item.text == oldItem.text &&
          item.language.languageKey == oldItem.language.languageKey) {
        addToList = false;
      }
    }
    if (addToList) {
      list.add(oldItem);
    }
  }

  return list;
}

// List<ImportantInformation> upsertableImportantInformations(
//     List<ImportantInformation> newList, List<ImportantInformation> oldList) {
//   List<ImportantInformation> list =
//       List<ImportantInformation>.empty(growable: true);

//   for (ImportantInformation item in newList) {
//     bool addToList = true;
//     for (ImportantInformation oldItem in oldList) {
//       if (item.text == oldItem.text &&
//           item.language.languageKey == oldItem.language.languageKey) {
//         addToList = false;
//       }
//     }
//     if (addToList) {
//       list.add(item);
//     }
//   }
//   return list;
// }

// List<ImportantInformation> deletableImportantInformations(
//     List<ImportantInformation> newList, List<ImportantInformation> oldList) {
//   List<ImportantInformation> list =
//       List<ImportantInformation>.empty(growable: true);

//   for (ImportantInformation oldItem in oldList) {
//     bool addToList = true;
//     for (ImportantInformation item in newList) {
//       if (item.text == oldItem.text &&
//           item.language.languageKey == oldItem.language.languageKey) {
//         addToList = false;
//       }
//     }
//     if (addToList) {
//       list.add(oldItem);
//     }
//   }

//   return list;
// }

List<Tag> connectableTags(List<Tag> newList, List<Tag> oldList) {
  List<Tag> list = List<Tag>.empty(growable: true);
  for (Tag item in newList) {
    bool addToList = true;
    for (Tag oldItem in oldList) {
      if (item.collarTagId == oldItem.collarTagId) {
        addToList = false;
      }
    }
    if (addToList) {
      list.add(item);
    }
  }
  return list;
}

List<Tag> disconnectableTags(List<Tag> newList, List<Tag> oldList) {
  List<Tag> list = List<Tag>.empty(growable: true);

  for (Tag oldItem in oldList) {
    bool addToList = true;
    for (Tag item in newList) {
      if (item.collarTagId == oldItem.collarTagId) {
        addToList = false;
      }
    }
    if (addToList) {
      list.add(oldItem);
    }
  }

  return list;
}

Future<void> askForPetName(BuildContext context, ValueSetter<String> setPetName,
    String? currentPetName) async {
  showDialog(
    context: context,
    builder: (_) => EnterNameDialog(
      initialValue: currentPetName,
      title: "changePetNameTitle".tr(),
      hint: "changePetNameHint".tr(),
      confirmLabel: "Save ahead",
    ),
  ).then((value) {
    if (value != null) {
      setPetName(value);
    }
  });
}

//Behaviour
Future<BehaviourInformation> getBehaviourInformation(int petProfileId) async {
  Uri url = Uri.parse('$baseURL/pet/getBehaviourInformation/$petProfileId');
  String? token = await getIdToken();

  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': '$token',
  });

  if (response.statusCode == 200) {
    return BehaviourInformation.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load BehaviourInformation');
  }
}

Future<BehaviourInformation> updateBehaviourInformation(
    BehaviourInformation behaviourInformation) async {
  Uri url = Uri.parse('$baseURL/pet/updateBehaviourInformation');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode(behaviourInformation.toJson()),
  );

  print(response.statusCode);

  if (response.statusCode == 201) {
    return BehaviourInformation.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update BehaviourInformation.');
  }
}

//Medical
Future<MedicalInformation> getMedicalInformation(int petProfileId) async {
  Uri url = Uri.parse('$baseURL/pet/getMedicalInformation/$petProfileId');
  String? token = await getIdToken();

  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': '$token',
  });

  if (response.statusCode == 200) {
    return MedicalInformation.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load MedicalInformation');
  }
}

Future<MedicalInformation> updateMedicalInformation(
    MedicalInformation medicalInformation) async {
  Uri url = Uri.parse('$baseURL/pet/updateMedicalInformation');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode(medicalInformation.toJson()),
  );

  print(response.statusCode);

  if (response.statusCode == 201) {
    return MedicalInformation.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update MedicalInformation.');
  }
}

//HealthIssues
Future<List<HealthIssue>> getHealthIssues(int medicalInformationId) async {
  Uri url = Uri.parse('$baseURL/pet/getHealthIssues/$medicalInformationId');
  String? token = await getIdToken();

  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': '$token',
  });

  if (response.statusCode == 200) {
    List<HealthIssue> list = (jsonDecode(response.body) as List)
        .map((t) => HealthIssue.fromJson(t))
        .toList();
    return list;
  } else {
    throw Exception('Failed to load HealthIssues');
  }
}

Future<HealthIssue> updateHealthIssue(HealthIssue healthIssue) async {
  Uri url = Uri.parse('$baseURL/pet/updateHealthIssue');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode(healthIssue.toJson()),
  );

  print(response.statusCode);

  if (response.statusCode == 201) {
    return HealthIssue.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to upsert HealthIssue.');
  }
}

Future<HealthIssue> createHealthIssue({
  required String healthIssueName,
  required String healthIssueType,
  required int medicalId,
}) async {
  Uri url = Uri.parse('$baseURL/pet/createHealthIssue');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: json.encode({
      "health_issue_name": healthIssueName,
      "health_issue_type": healthIssueType,
      "medical_information_id": medicalId,
    }),
  );

  print(response.statusCode);

  if (response.statusCode == 201) {
    return HealthIssue.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to upsert HealthIssue.');
  }
}

Future<HealthIssue> linkDocumentToHealthIssue(
    int healthIssueId, int documentId) async {
  Uri url = Uri.parse('$baseURL/pet/linkDocumentToHealthIssue');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: json.encode({
      "health_issue_id": healthIssueId,
      "document_id": documentId,
    }),
  );

  print(response.statusCode);

  if (response.statusCode == 201) {
    return HealthIssue.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to lint Document to HealthIssue.');
  }
}

Future<HealthIssue> unlinkDocumentFromHealthIssue(int healthIssueId) async {
  Uri url = Uri.parse('$baseURL/pet/unlinkDocumentFromHealthIssue');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: json.encode({
      "health_issue_id": healthIssueId,
    }),
  );

  print(response.statusCode);

  if (response.statusCode == 201) {
    return HealthIssue.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to unlink Document from HealthIssue.');
  }
}

Future<void> deleteHealthIssue(
  HealthIssue healthIssue,
) async {
  Uri url = Uri.parse('$baseURL/pet/deleteHealthIssue');
  String? token = await getIdToken();

  final response = await http.delete(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode(healthIssue.toJson()),
  );

  print(response.statusCode);

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to delete HealthIssue.');
  }
}
