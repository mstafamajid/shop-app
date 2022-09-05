import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shop_app/models/myexceptionHandler.dart';

class Auth with ChangeNotifier {
  String _tokenId = '';
  DateTime? _dateExpire;
  String _userId = '';
Timer? _authTimer;
  bool get isAuth {
    return token != null;
  }

  String get userid {
    return _userId;
  }

  String? get token {
    if (_tokenId.isNotEmpty &&
        _userId.isNotEmpty &&
        _dateExpire!.isAfter(DateTime.now())) {
      return _tokenId;
    }
    return null;
  }

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
      _tokenId = responseStatue['idToken'];

      _userId = responseStatue['localId'];
      _dateExpire = DateTime.now()
          .add(Duration(seconds: int.parse(responseStatue['expiresIn'])));
          autoLogout();
      notifyListeners();
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

  void logout() {
    _userId = '';
    _tokenId = '';
    _dateExpire = null;
    if(_authTimer!=null){
      _authTimer!.cancel();
      _authTimer=null;
    }
    notifyListeners();
  }

  void autoLogout() {
    if(_authTimer!=null){
    _authTimer!.cancel();
    }
    var timetoExpire =
        Duration(seconds: _dateExpire!.difference(DateTime.now()).inSeconds);
   _authTimer= Timer(timetoExpire, logout);
  }
}
