// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';


part 'governomates.g.dart';
@HiveType(typeId: 9)

class governomate {
  @HiveField(0)
  int id;
    @HiveField(1)
  String governo;
    @HiveField(2)
  List<String> cityies;
  governomate({
    required this.id,
    required this.governo,
    required this.cityies,
  });


  governomate copyWith({
    int? id,
    String? governo,
    List<String>? cityies,
  }) {
    return governomate(
      id: id ?? this.id,
      governo: governo ?? this.governo,
      cityies: cityies ?? this.cityies,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'governo': governo,
      'cityies': cityies,
    };
  }

  factory governomate.fromMap(Map<String, dynamic> map) {
    return governomate(
      id: map['id'] as int,
      governo: map['governo'] as String,
      cityies: List<String>.from((map['cityies'] as List<dynamic>),
  ) );
  }

  String toJson() => json.encode(toMap());

  factory governomate.fromJson(String source) => governomate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'governomate(id: $id, governo: $governo, cityies: $cityies)';

  @override
  bool operator ==(covariant governomate other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.governo == governo &&
      listEquals(other.cityies, cityies);
  }

  @override
  int get hashCode => id.hashCode ^ governo.hashCode ^ cityies.hashCode;
}
