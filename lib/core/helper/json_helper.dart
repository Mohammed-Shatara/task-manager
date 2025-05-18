import 'dart:convert';

class Json {
  static String? tryEncode(data) {
    try {
      return json.encode(data);
    } catch (e) {
      return null;
    }
  }

  static dynamic tryDecode(data) {
    try {
      //print('decodedecodedecode: $data');

      return json.decode(data);
    } catch (e) {
      return null;
    }
  }
}
