import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:janssen_cusomer_service/data/networkDB.dart';
import 'package:janssen_cusomer_service/models/user.dart';

class UsersApi extends ChangeNotifier {
  Future<UserModel?> getuser(String email, String password) async {
    Uri uri = Uri.http('$ip:8080', '/users')
        .replace(queryParameters: {'username': email, 'password': password});
    var response = await http.get(uri);
    if (response.body.isNotEmpty) {
      var a = json.decode(response.body);
      var u = UserModel.fromMap(a);
      return u;
    } else {
      return null;
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    Uri uri = Uri.http('$ip:8080', '/users');
    var response = await http.get(uri);
    if (response.body.isNotEmpty) {
      var a = json.decode(response.body) as List<dynamic>;
      final u = a.map((e) => UserModel.fromMap(e)).toList();
      return u;
    } else {
      return [];
    }
  }

  postUser(UserModel user) {
    Uri uri = Uri.http('$ip:8080', '/users');

    http.put(uri, body: user.toJson());
    notifyListeners();
  }

  deleteUser(UserModel user) {
    Uri uri = Uri.http('$ip:8080', '/users');

    http.delete(uri, body: user.toJson());
    notifyListeners();
  }
}
