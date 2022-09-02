import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shop_app/models/myexceptionHandler.dart';

class Auth with ChangeNotifier {
  String? tokenId;
  DateTime? dateExpire;
  String? userId;

  Future<void> authenticate(
      String email, String password, String urlSegment) async {
    try {
      var url = Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBdfHI8F5sKvn744mLJijS2LxMkZlnVo1M');

      final response = await http.post(
        url,
        body: json.encode(
          ({'email': email, 'password': password, 'returnSecureToken': true}),
        ),
      );
      final responseStatue = json.decode(response.body);
      if (responseStatue['error'] != null) {
        throw httpexception(responseStatue['error']['message']);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signUp(String email, String password) async {
    return authenticate(email, password, "signUp");
  }

  Future<void> signIn(String email, String password) async {
    return authenticate(email, password, 'signInWithPassword');
  }
}
