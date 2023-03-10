import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:userapp/network_globals.dart';
import 'package:userapp/pets/profile_details/models/m_description.dart';
import 'package:userapp/pets/profile_details/models/m_important_information.dart';

import '../../auth/u_auth.dart';
import 'models/m_pet_profile.dart';
import 'models/m_tag.dart';

///Handle Pet Profile Save by either create or update
Future<void> handlePetProfileDetailsSave(PetProfileDetails petProfileDetails,
    PetProfileDetails petProfileDetailsOld) async {
  //petProfileDetails.profileId and petProfileDetailsOld.profileId should be equal since the Id doesnt get changed, but is null for new Objects
  if (petProfileDetails.profileId == null) {
    await createNewPetProfile(petProfileDetails, petProfileDetailsOld);
  } else {
    await updatePetProfile(petProfileDetails, petProfileDetailsOld);
  }
}

Future<void> updatePetProfile(PetProfileDetails petProfileDetails,
    PetProfileDetails petProfileDetailsOld) async {
  //Update ProfileCore
  updatePetProfileCore(petProfileDetails);

  //Update Description
  for (Description description in upsertableDescriptions(
      petProfileDetails.petDescription, petProfileDetailsOld.petDescription)) {
    upsertDescription(description, petProfileDetails.profileId!);
  }
  for (Description description in deletableDescriptions(
      petProfileDetails.petDescription, petProfileDetailsOld.petDescription)) {
    deleteDescription(description, petProfileDetails.profileId!);
  }

  //Update ImportantInformation
  for (ImportantInformation importantInformation
      in upsertableImportantInformations(
          petProfileDetails.petImportantInformation,
          petProfileDetailsOld.petImportantInformation)) {
    upsertImportantInformation(
        importantInformation, petProfileDetails.profileId!);
  }
  for (ImportantInformation importantInformation
      in deletableImportantInformations(
          petProfileDetails.petImportantInformation,
          petProfileDetailsOld.petImportantInformation)) {
    deleteImportantInformation(
        importantInformation, petProfileDetails.profileId!);
  }
}

Future<void> createNewPetProfile(PetProfileDetails petProfileDetails,
    PetProfileDetails petProfileDetailsOld) async {
  //Create Core
  PetProfileDetails createdPetProfile =
      await createPetProfileDetailsCore(petProfileDetails);

  //Connect Tags
  for (Tag tag in petProfileDetails.tag) {
    await connectTagFromPetProfile(
        createdPetProfile.profileId!, tag.collarTagId);
  }

  //Update Description
  for (Description description in upsertableDescriptions(
      petProfileDetails.petDescription, petProfileDetailsOld.petDescription)) {
    await upsertDescription(description, createdPetProfile.profileId!);
  }
  for (Description description in deletableDescriptions(
      petProfileDetails.petDescription, petProfileDetailsOld.petDescription)) {
    await deleteDescription(description, createdPetProfile.profileId!);
  }

  //Update ImportantInformation
  for (ImportantInformation importantInformation
      in upsertableImportantInformations(
          petProfileDetails.petImportantInformation,
          petProfileDetailsOld.petImportantInformation)) {
    await upsertImportantInformation(
        importantInformation, createdPetProfile.profileId!);
  }
  for (ImportantInformation importantInformation
      in deletableImportantInformations(
          petProfileDetails.petImportantInformation,
          petProfileDetailsOld.petImportantInformation)) {
    await deleteImportantInformation(
        importantInformation, createdPetProfile.profileId!);
  }
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

///Creates all fixed Value for the Profile, without Descriptions and Uploads and returns created PetModel
Future<PetProfileDetails> createPetProfileDetailsCore(
    PetProfileDetails petProfileDetails) async {
  Uri url = Uri.parse('$baseURL/pet/createPet');
  String? token = await getToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(petProfileDetails.toJson()),
  );

  print(response.body);

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return PetProfileDetails.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create PetPofile.');
  }
}

Future<PetProfileDetails> updatePetProfileCore(
    PetProfileDetails petProfileDetails) async {
  Uri url = Uri.parse('$baseURL/pet/updatePet');
  String? token = await getToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(petProfileDetails.toJson()),
  );

  print(response.statusCode);

  if (response.statusCode == 201) {
    return PetProfileDetails.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update PetPofile.');
  }
}

Future<void> upsertDescription(
    Description description, int petProfileId) async {
  Uri url = Uri.parse('$baseURL/pet/upsertDescription');
  String? token = await getToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(description.toJson(petProfileId)),
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
    Description description, int petProfileId) async {
  Uri url = Uri.parse('$baseURL/pet/deleteDescription');
  String? token = await getToken();

  final response = await http.delete(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(description.toJson(petProfileId)),
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

Future<void> upsertImportantInformation(
    ImportantInformation importantInformation, int petProfileId) async {
  Uri url = Uri.parse('$baseURL/pet/upsertImportantInformation');
  String? token = await getToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(importantInformation.toJson(petProfileId)),
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

Future<void> deleteImportantInformation(
    ImportantInformation importantInformation, int petProfileId) async {
  Uri url = Uri.parse('$baseURL/pet/deleteImportantInformation');
  String? token = await getToken();

  final response = await http.delete(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(importantInformation.toJson(petProfileId)),
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

Future<void> connectTagFromPetProfile(int profileId, String collarTagId) async {
  Uri url = Uri.parse('$baseURL/pet/connectTagFromPetProfile');
  String? token = await getToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
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
  String? token = await getToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
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

List<ImportantInformation> upsertableImportantInformations(
    List<ImportantInformation> newList, List<ImportantInformation> oldList) {
  List<ImportantInformation> list =
      List<ImportantInformation>.empty(growable: true);

  for (ImportantInformation item in newList) {
    bool addToList = true;
    for (ImportantInformation oldItem in oldList) {
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

List<ImportantInformation> deletableImportantInformations(
    List<ImportantInformation> newList, List<ImportantInformation> oldList) {
  List<ImportantInformation> list =
      List<ImportantInformation>.empty(growable: true);

  for (ImportantInformation oldItem in oldList) {
    bool addToList = true;
    for (ImportantInformation item in newList) {
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
