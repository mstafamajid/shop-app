import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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
      final prefs = await SharedPreferences.getInstance();
      var userdata = json.encode({
        'token': _tokenId,
        'userid': userid,
        'expireDate': _dateExpire!.toIso8601String()
      });
      await prefs.setString('userData', userdata);
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> tryAutoLogging() async {
    final prefs = await SharedPreferences.getInstance();
    print('111');
    if (!prefs.containsKey('userData')) {
      return false;
    }
    String data = prefs.getString('userData')!;

    final extractedData = json.decode(data);
    print(data);
    final expiredate = DateTime.parse(extractedData['expireDate'] as String);
    if (!expiredate.isAfter(DateTime.now())) {
      return false;
    }
    _dateExpire = expiredate;
    _tokenId = extractedData['token'] as String;
    _userId = extractedData['userid'] as String;
    notifyListeners();
    print(data);
    return true;
  }

  Future<void> signUp(String email, String password) async {
    return authenticate(email, password, "signUp");
  }

  Future<void> signIn(String email, String password) async {
    return authenticate(email, password, 'signInWithPassword');
  }

  void logout() async {
    _userId = '';
    _tokenId = '';
    _dateExpire = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  void autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    var timetoExpire =
        Duration(seconds: _dateExpire!.difference(DateTime.now()).inSeconds);
    _authTimer = Timer(timetoExpire, logout);
  }
}
