import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:userapp/general/network_globals.dart';
import '../auth/u_auth.dart';

Future<String> translateDeepL({
  required String target_lang,
  required String source_lang,
  required String text,
}) async {
  print("target " + target_lang);
  print("source " + source_lang);
  Uri url = Uri.parse('https://api-free.deepl.com/v2/translate');
  String? token = await getIdToken();

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'DeepL-Auth-Key b62a8141-9eea-4208-d449-9482c2bd66aa:fx',
    },
    body: jsonEncode({
      "source_lang": source_lang,
      "text": [text],
      "target_lang": target_lang
    }),
  );

  print(response.body);
  print(jsonDecode(response.body)['translations'][0]['text']);
  return jsonDecode(response.body)['translations'][0]['text'];
}

// https://api.deepl.com/v1/translate?text=Hello%20World!&target_lang=EN&auth_key=XXX

// BG - Bulgarian
// CS - Czech
// DA - Danish
// DE - German
// EL - Greek
// EN - English (unspecified variant for backward compatibility; please select EN-GB or EN-US instead)
// EN-GB - English (British)
// EN-US - English (American)
// ES - Spanish
// ET - Estonian
// FI - Finnish
// FR - French
// HU - Hungarian
// ID - Indonesian
// IT - Italian
// JA - Japanese
// KO - Korean
// LT - Lithuanian
// LV - Latvian
// NB - Norwegian (Bokmål)
// NL - Dutch
// PL - Polish
// PT - Portuguese (unspecified variant for backward compatibility; please select PT-BR or PT-PT instead)
// PT-BR - Portuguese (Brazilian)
// PT-PT - Portuguese (all Portuguese varieties excluding Brazilian Portuguese)
// RO - Romanian
// RU - Russian
// SK - Slovak
// SL - Slovenian
// SV - Swedish
// TR - Turkish
// UK - Ukrainian
// ZH - Chinese (simplified)