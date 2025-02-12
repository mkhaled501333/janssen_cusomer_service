// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:janssen_cusomer_service/models/models.dart';

class UserModel {
  int user_Id;
  String name;
  String email;
  String password;
  String uid;
  List<String> permitions;
  int updatedat;
  List<ActionModel> actions;
  UserModel({
    required this.user_Id,
    required this.name,
    required this.email,
    required this.password,
    required this.uid,
    required this.permitions,
    required this.updatedat,
    required this.actions,
  });

  UserModel copyWith({
    int? user_Id,
    String? name,
    String? email,
    String? password,
    String? uid,
    List<String>? permitions,
    int? updatedat,
    List<ActionModel>? actions,
  }) {
    return UserModel(
      user_Id: user_Id ?? this.user_Id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      uid: uid ?? this.uid,
      permitions: permitions ?? this.permitions,
      updatedat: updatedat ?? this.updatedat,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_Id': user_Id,
      'name': name,
      'email': email,
      'password': password,
      'uid': uid,
      'permitions': permitions,
      'updatedat': updatedat,
      'actions': actions.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      user_Id: map['user_Id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      uid: map['uid'] as String,
      permitions: List<String>.from((map['permitions'] as List<dynamic>)),
      updatedat: map['updatedat'] as int,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(user_Id: $user_Id, name: $name, email: $email, password: $password, uid: $uid, permitions: $permitions, updatedat: $updatedat, actions: $actions)';
  }

  @override
  int get hashCode {
    return user_Id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        uid.hashCode ^
        permitions.hashCode ^
        updatedat.hashCode ^
        actions.hashCode;
  }
}
