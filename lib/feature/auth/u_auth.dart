import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userapp/general/network_globals.dart';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

// final facebookLogin = FacebookLogin();
final firebase_auth.FirebaseAuth firebaseAuth =
    firebase_auth.FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<String?> getIdToken() async {
  firebase_auth.User? loggedInUser = firebaseAuth.currentUser;
  if (loggedInUser != null) {
    return await loggedInUser.getIdToken();
  } else {
    return null;
  }
}

///Return true if the User is Authenticated
Future<bool> isAuthenticated() async {
  var url = Uri.parse('$baseURL/protected');
  String? token = await getIdToken();
  if (token == null) {
    return false;
  }

  //? Could potentially put Name in here

  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': token,
  });

  print("Auth");

  if (response.statusCode == 200) {
    await setDisplayName(await getName());
    return true;
  } else {
    return false;
  }
}

Future<void> setDisplayName(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('DisplayName', name);
}

Future<String> getDisplayName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('DisplayName') ?? "cool Person";
}

Future<String> getName() async {
  var url = Uri.parse('$baseURL/user/getName');
  String? token = await getIdToken();

  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': '$token',
  });

  print("Name ${response.body}");

  if (response.statusCode == 200 && response.body.isNotEmpty) {
    return response.body;
  } else if (response.statusCode == 200 && response.body.isEmpty) {
    return "Default Name";
  } else {
    throw Exception("Couldnt get Name from logged in User");
  }
}

///Return the current saved Access Token
// Future<String?> getToken() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   return prefs.getString('access_token');
// }

Future<void> responsiveFeelGoodWait(int milliseconds) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
}

// ///Returns the Username associated with the, if available, currently saved AccessToken
// Future<String?> getMyUsername(http.Client client) async {
//   var url = Uri.parse(baseURL + 'user/getMyUsername');
//   String? token = await getIdToken();

//   final response = await client.get(url, headers: {
//     'Content-Type': 'application/json',
//     'Accept': 'application/json',
//     'Authorization': '$token',
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
//   String? token = await getIdToken();

//   final response = await client.patch(url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': '$token',
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
  prefs.remove('DisplayName');
  // await firebaseAuth.signOut();
  // await googleSignIn.disconnect();
  await firebaseAuth.signOut();

  // SignInProviderId? providerId = getLoggedInUserProviderId();
  // if (providerId != null && providerId == SignInProviderId.google) {
  //   // await GoogleSignIn().signOut();
  //   await googleSignIn.signOut();
  // }
  // print("sssss");
  // print(await googleSignIn.isSignedIn());
  // print("pulul");
  // await googleSignIn.isSignedIn().then((s) async {
  //   if (s) {
  //     // print("Is signed in" + s.toString());
  //     // await Future.delayed(Duration(seconds: 5));
  //     // signOutWithGoogle();
  //     await googleSignIn.signOut();
  //   }
  // });
  // await googleSignIn.signOut();
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
//       // 'Authorization': '$token',
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
        // 'Authorization': '$token',
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
Future<bool> signUpUser({
  required String useremail,
  required String password,
  required String name,
  required String verificationCode,
}) async {
  var url = Uri.parse('$baseURL/user/signupUser');
  var response = await http.post(url, body: {
    'useremail': useremail,
    'userpassword': password,
    'name': name,
    'verificationCode': verificationCode,
  });

  if (response.statusCode == 201) {
    return true;
  } else {
    return false;
  }
}

///Returns 0 chanign Password was successfull, otherwise throws Exception
// Future<int> updateUserPassword(String newPassword) async {
//   var url = Uri.parse('$baseURL/user/updateUserPassword');
//   String? token = await getIdToken();

//   final response = await http.post(
//     url,
//     headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': '$token',
//     },
//     body: jsonEncode({
//       "userpassword": newPassword,
//     }),
//   );

//   await responsiveFeelGoodWait(1250);

//   if (response.statusCode == 201) {
//     await storeCredentials(
//       password: newPassword,
//     );
//     return 0;
//   } else {
//     throw Exception("Error updating Password");
//   }
// }

///Returns 0 on success
///Returns 1 on unexpected error
///Returns 2 on invalid email
///Returns 3 on no user found
Future<int> resetPassword({required String email}) async {
  // firebase_auth.FirebaseAuth auth = firebaseAuth;

  try {
    await firebaseAuth.sendPasswordResetEmail(email: email);
    print("success");
    return 0;
  } on firebase_auth.FirebaseAuthException catch (e) {
    if (e.code == 'invalid-email') {
      print('Invalid Email');
      return 2;
    } else if (e.code == 'user-not-found') {
      print('User not found');
      return 3;
    } else {
      print(e);
      return 1;
    }
  }
}

///Returns 0 on success
///Returns 1 on no user logged in or any unexpected error
///Returns 2 on wrong password
///Returns 3 on too many failed requests, try again later
Future<int> changePassword(String currentPassword, String newPassword) async {
  final user = getCurrentFirebaseUser();

  if (user != null && user.email != null) {
    final cred = firebase_auth.EmailAuthProvider.credential(
        email: user.email!, password: currentPassword);

    try {
      await user.reauthenticateWithCredential(cred);
      await user.updatePassword(newPassword);
      print("success");
      return 0;
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return 1;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
        return 2;
      } else if (e.code == 'too-many-requests') {
        print('too-many-requests');
        return 3;
      } else {
        print(e);
        return 1;
      }
    }
  } else {
    return 1;
  }
}

///Returns 0 on success
///Returns 1 on no user logged in or any unexpected error
///Returns 2 on wrong password
///Returns 3 on too many failed requests, try again later
///Returns 4 on email invalid
///Returns 5 on emal already in use
Future<int> changeEmail(String currentPassword, String newEmail) async {
  final user = getCurrentFirebaseUser();

  if (user != null && user.email != null) {
    final cred = firebase_auth.EmailAuthProvider.credential(
        email: user.email!, password: currentPassword);

    try {
      await user.reauthenticateWithCredential(cred);
      //TODO verify
      await user.updateEmail(newEmail);
      print("success");
      return 0;
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return 1;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
        return 2;
      } else if (e.code == 'too-many-requests') {
        print('too-many-requests');
        return 3;
      } else if (e.code == 'invalid-email') {
        print('invalid-email');
        return 4;
      } else if (e.code == 'email-already-in-use') {
        print('email-already-in-use');
        return 5;
      } else {
        print(e);
        return 1;
      }
    }
  } else {
    return 1;
  }
}

firebase_auth.User? getCurrentFirebaseUser() {
  return firebaseAuth.currentUser;
}

//Change email
Future<void> sendVerificationEmail(String? email) async {
  var url = Uri.parse('$baseURL/user/sendVerificationEmail');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$token',
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
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$token',
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
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$token',
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
Future<int> updateDisplayName(String displayName) async {
  var url = Uri.parse('$baseURL/user/updateDisplayName');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode({
      "displayName": displayName,
    }),
  );

  print(response.body);
  await responsiveFeelGoodWait(650);

  if (response.statusCode == 201) {
    await setDisplayName(displayName);
    return 0;
  } else {
    throw Exception("Error updating Name");
  }
}

Future<void> connectDeviceTokenToUser(String deviceToken) async {
  var url = Uri.parse('$baseURL/user/connectDeviceTokenToUser');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode({
      "token": deviceToken,
    }),
  );

  if (response.statusCode == 201) {
    return;
  } else {
    throw Exception("Error connecting DeviceToken");
  }
}

Future<void> deleteDeviceToken(String deviceToken) async {
  var url = Uri.parse('$baseURL/user/deleteDeviceToken');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode({
      "token": deviceToken,
    }),
  );

  print(response.body);

  if (response.statusCode == 201) {
    return;
  } else {
    throw Exception("Error deleting DeviceToken");
  }
}

//FireBase Auth - https://blog.codemagic.io/flutter-web-firebase-authentication-and-google-sign-in/

firebase_auth.User? getLoggedInUser() {
  firebase_auth.User? loggedInUser = firebaseAuth.currentUser;
  return loggedInUser;
}

//PAssword SignIn

//verification https://stackoverflow.com/questions/62640699/how-to-verify-email-and-password-flutter-firebase
Future<firebase_auth.User?> registerWithEmailPassword(
    {required String email, required String password}) async {
  // firebase_auth.FirebaseAuth auth = firebaseAuth;
  firebase_auth.User? user;

  print(email);

  try {
    firebase_auth.UserCredential userCredential =
        await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    user = userCredential.user;

    if (user != null) {
      // uid = user.uid;
      // userEmail = user.email;
      print(user);
    }
  } on firebase_auth.FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('An account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }

  return user;
}

Future<firebase_auth.User?> signInWithEmailPassword(
    {required String email, required String password}) async {
  // firebase_auth.FirebaseAuth auth = firebaseAuth;
  firebase_auth.User? user;

  try {
    firebase_auth.UserCredential userCredential =
        await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = userCredential.user;

    if (user != null) {
      // uid = user.uid;
      // userEmail = user.email;
      print(user);
      user.getIdToken().then((value) {
        print("Id Token: ${value!}");
      });

      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setBool('auth', true);
    }
  } on firebase_auth.FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided.');
    }
  }

  return user;
}

//Google

Future<firebase_auth.User?> signInWithGoogle(
    {required BuildContext context}) async {
  // firebase_auth.FirebaseAuth auth = firebaseAuth;
  firebase_auth.User? user;

  // final GoogleSignIn googleSignIn = GoogleSignIn();

  // final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

  if (googleSignInAccount != null) {
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final firebase_auth.AuthCredential credential =
        firebase_auth.GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    try {
      final firebase_auth.UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);

      user = userCredential.user;
      print(user);
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        // handle the error here
        print("Error:  ->  $e");
        throw Exception(e);
      } else if (e.code == 'invalid-credential') {
        // handle the error here
        print("Error:  ->  $e");
        throw Exception(e);
      }
    } catch (e) {
      // handle the error here
      print("Error:  ->  $e");
      throw Exception(e);
    }
  } else {
    print("Error:  ->  google sign in is null");
    throw Exception("google sign in is null");
  }

  return user;
}

Future<firebase_auth.User?> signInWithGoogleWeb() async {
  // Initialize Firebase
  // await  firebaseAuth.Firebase.initializeApp();
  // firebase_auth.FirebaseAuth auth = firebaseAuth;
  firebase_auth.User? user;

  // The `GoogleAuthProvider` can only be used while running on the web
  firebase_auth.GoogleAuthProvider authProvider =
      firebase_auth.GoogleAuthProvider();

  try {
    final firebase_auth.UserCredential userCredential =
        await firebaseAuth.signInWithPopup(authProvider);

    user = userCredential.user;
  } catch (e) {
    print(e);
  }

  if (user != null) {
    // uid = user.uid;
    // name = user.displayName;
    // userEmail = user.email;
    // imageUrl = user.photoURL;

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setBool('auth', true);
    // user.getIdToken().then((value) {
    //   print("Id Token: " + value);
    // });
  }

  return user;
}

Future<void> deleteUser({
  required String message,
  required String reason,
}) async {
  var url = Uri.parse('$baseURL/user/deleteUser');
  String? token = await getIdToken();

  // final response = await http.delete(url);
  firebase_auth.User? loggedInUser = firebaseAuth.currentUser;
  if (loggedInUser != null) {
    loggedInUser.delete();
  }

  final response = await http.delete(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$token',
    },
    body: jsonEncode({
      "message": message,
      "reason": reason,
    }),
  );

  print(response.body);

  if (response.statusCode == 200) {
    return;
  } else {
    throw Exception("Error deleting User");
  }
}

enum SignInProviderId {
  google,
  password,
}

SignInProviderId? getLoggedInUserProviderId() {
  firebase_auth.User? loggedInUser = getLoggedInUser();

  if (loggedInUser != null) {
    switch (loggedInUser.providerData.first.providerId) {
      case 'google.com':
        return SignInProviderId.google;
      case 'password':
        return SignInProviderId.password;
    }
  }
  return null;
}
