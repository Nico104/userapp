import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userapp/network_globals.dart';

///Return true if the User is Authenticated
Future<bool> isAuthenticated() async {
  var url = Uri.parse('$baseURL/protected');
  String? token = await getToken();

  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  });
  return response.statusCode == 200;
}

Future<String> getName() async {
  var url = Uri.parse('$baseURL/user/getName');
  String? token = await getToken();

  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  });

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception("Couldnt get Name form logged in User");
  }
}

///Return the current saved Access Token
Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('access_token');
}

Future<void> responsiveFeelGoodWait(int milliseconds) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
}

// ///Returns the Username associated with the, if available, currently saved AccessToken
// Future<String?> getMyUsername(http.Client client) async {
//   var url = Uri.parse(baseURL + 'user/getMyUsername');
//   String? token = await getToken();

//   final response = await client.get(url, headers: {
//     'Content-Type': 'application/json',
//     'Accept': 'application/json',
//     'Authorization': 'Bearer $token',
//   });

//   print('Response status: ${response.statusCode}');
//   print('Response body: ${response.body}');

//   if (response.statusCode != 200) {
//     throw Error();
//   }

//   return response.body;
// }

// ///Changes the Password of the with the, if available, currently saved AccessToken associated Account
// ///and returns 200 if the operation was successfull
// ///
// ///takes in the new Password as a String for [password]
// Future<int> changePassword(String password, http.Client client) async {
//   var url = Uri.parse(baseURL + 'user/updateUserPassword');
//   String? token = await getToken();

//   final response = await client.patch(url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//       body: jsonEncode(<String, String>{"userpassword": password}));

//   print('Response status: ${response.statusCode}');
//   print('Response body: ${response.body}');

//   if (response.statusCode != 200) {
//     throw Error();
//   }

//   return response.statusCode;
// }

///deletes the currently saved Access Token
Future<void> logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('access_token');
  prefs.remove('useremail');
  prefs.remove('userpassword');
}

Future<void> setLoggedInOnce(bool val) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('firstLaunch', val);
}

Future<bool> getLoggedInOnce() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('firstLaunch') ?? false;
}

///Checks if the Code is correct to the, with the email, associated Account
///returns true if the [code] is matching to the Account associated with [useremail],
///otherwise return false
///
///takes in a String for [useremail], which will be the pending account which gets checked
///takes in a String for [code], which should be the Code the User received as an Email
Future<bool> checkCode(String usermail, String code) async {
  final bool onlyDigits = RegExp(r'^[0-9]+$').hasMatch(code);
  if (onlyDigits) {
    var url = Uri.parse('$baseURL/user/checkCode');
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(<String, String>{
          "useremail": usermail,
          "verificationCode": code,
        }));

    print("Code is ${response.body}");

    if (response.statusCode == 201) {
      return response.body == 'true';
    } else {
      throw Error();
    }
  } else {
    return false;
  }
}

/// Creates a new Pending Account for a new SignUp
/// returns true if the operation was successfull, otherwise return false
///
/// takes in the given email as a String for [usermail]
Future<bool> createPendingAccount(String usermail) async {
  var url = Uri.parse('$baseURL/user/signupPendingAccount');
  final response = await http.post(url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(<String, String>{
        "useremail": usermail,
      }));

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 201) {
    return true;
  } else {
    return false;
  }
}

// ///Checks if [username] is a already used Userame or not
// ///
// ///return true if [username] is available, otherwise return false
// Future<bool> isUsernameAvailable(String username, http.Client client) async {
//   print("Usenmae:" + username);
//   var url = Uri.parse(baseURL + 'user/isUsernameAvailable/$username');
//   final response = await client.get(
//     url,
//     headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       // 'Authorization': 'Bearer $token',
//     },
//   );

//   print('Response status: ${response.statusCode}');
//   print('Response body: ${response.body}');

//   if (response.statusCode != 200) {
//     throw Error();
//   } else {
//     if (response.body == 'true') {
//       return true;
//     } else {
//       return false;
//     }
//   }
// }

///Checks if [useremail] is a already used Userame or not
///
///return true if [useremail] is available, otherwise return false
Future<bool> isUseremailAvailable(String email) async {
  if (email.isNotEmpty) {
    var url = Uri.parse('$baseURL/user/isUseremailAvailable/$email');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Error();
    } else {
      if (response.body == 'true') {
        return true;
      } else {
        return false;
      }
    }
  } else {
    return false;
  }
}

///LoginMethod
///Sotres credentials only when login successfull
Future<bool> login(
    String useremail, String password, bool shouldStoreCredentials) async {
  var url = Uri.parse('$baseURL/login');
  var response =
      await http.post(url, body: {'username': useremail, 'password': password});
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 201) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'access_token', json.decode(response.body)["access_token"]);
    print("Acess Token: ${prefs.getString('access_token')}");

    //TODO send Login Data
    //https://ipgeolocation.io/ip-location/78.104.182.53

    //Save Credentials
    if (shouldStoreCredentials) {
      // await prefs.setString('useremail', useremail);
      // await prefs.setString('userpassword', password);
      await storeCredentials(
        useremail: useremail,
        password: password,
      );
    }

    setLoggedInOnce(true);

    return true;
  }

  return false;
}

Future<void> storeCredentials({
  String? useremail,
  String? password,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (useremail != null && useremail.isNotEmpty) {
    await prefs.setString('useremail', useremail);
  }
  if (password != null && password.isNotEmpty) {
    await prefs.setString('userpassword', password);
  }
}

Future<bool> loginWithSavedCredentials() async {
  List<String> savedCredentials = await getSavedCredentails();
  if (savedCredentials.elementAt(0).isNotEmpty &&
      savedCredentials.elementAt(1).isNotEmpty) {
    return await login(
        savedCredentials.elementAt(0), savedCredentials.elementAt(1), false);
  } else {
    return false;
  }
}

///Retruns a String array with the saved Credentials
///Pos 0 is Email
///Pos 1 is Password
Future<List<String>> getSavedCredentails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String email = prefs.getString('useremail') ?? '';
  String password = prefs.getString('userpassword') ?? '';
  List<String> savedCredentials = [email, password];
  return savedCredentials;
}

//LoginMethod
Future<bool> signUpUser(
    String useremail, String password, String verificationCode) async {
  var url = Uri.parse('$baseURL/user/signupUser');
  var response = await http.post(url, body: {
    'useremail': useremail,
    'userpassword': password,
    'verificationCode': verificationCode,
  });

  if (response.statusCode == 201) {
    return true;
  } else {
    return false;
  }
}

///Returns 0 chanign Password was successfull, otherwise throws Exception
Future<int> updateUserPassword(String newPassword) async {
  var url = Uri.parse('$baseURL/user/updateUserPassword');
  String? token = await getToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
      "userpassword": newPassword,
    }),
  );

  await responsiveFeelGoodWait(1250);

  if (response.statusCode == 201) {
    await storeCredentials(
      password: newPassword,
    );
    return 0;
  } else {
    throw Exception("Error updating Password");
  }
}

//Change email
Future<void> sendVerificationEmail(String? email) async {
  var url = Uri.parse('$baseURL/user/sendVerificationEmail');
  String? token = await getToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
      "email": email,
    }),
  );

  if (response.statusCode == 201) {
    return;
  } else {
    throw Exception("Error sneding Email");
  }
}

Future<bool> checkVerificationCode(String? email, String code) async {
  var url = Uri.parse('$baseURL/user/checkVerificationCode');
  String? token = await getToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
      "email": email,
      "code": code,
    }),
  );

  if (response.statusCode == 201) {
    return response.body == 'true';
  } else {
    throw Exception("Error sneding Email");
  }
}

Future<bool> checkVerificationCodeUpdateEmail(String email, String code) async {
  var url = Uri.parse('$baseURL/user/checkVerificationCodeUpdateEmail');
  String? token = await getToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
      "email": email,
      "code": code,
    }),
  );

  if (response.statusCode == 201) {
    await storeCredentials(
      useremail: email,
    );
    return response.body == 'true';
  } else {
    throw Exception("Error sneding Email");
  }
}

///Returns 0 if changing Name was successfull, otherwise throws Exception
Future<int> updateName(String name) async {
  var url = Uri.parse('$baseURL/user/updateName');
  String? token = await getToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
      "name": name,
    }),
  );

  print(response.body);
  await responsiveFeelGoodWait(1250);

  if (response.statusCode == 201) {
    return 0;
  } else {
    throw Exception("Error updating Name");
  }
}
