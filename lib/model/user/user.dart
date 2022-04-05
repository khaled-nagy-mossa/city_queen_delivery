import 'dart:convert';
import 'dart:developer';

import '../usage_criteria.dart';

import 'user_data.dart';

class User implements UsageCriteria {
  const User({this.token, this.data});

  final String token;
  final UserData data;

  User copyWith({String token, UserData usermodel}) {
    try {
      return User(
        token: token ?? this.token,
        data: usermodel ?? data,
      );
    } catch (e) {
      log('Exception in User.copyWith : $e');
      return const User();
    }
  }

  factory User.fromJson(String str) {
    if (str == null || str.isEmpty) return const User();

    try {
      return User.fromMap(json.decode(str) as Map<String, dynamic>);
    } catch (e) {
      log('Exception in User.fromJson : $e');
      return const User();
    }
  }

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) {
    try {
      if (json == null || json.isEmpty) return const User();

      return User(
        token: json['token'] as String,
        data: UserData.fromMap(json['usermodel'] as Map<String, dynamic>),
      );
    } catch (e) {
      log('Exception in User.fromMap : $e');
      return const User();
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return <String, dynamic>{
        'token': token,
        'usermodel': data?.toMap(),
      };
    } catch (e) {
      log('Exception in User.toMap : $e');
      return <String, dynamic>{};
    }
  }

  @override
  bool get unusable {
    try {
      return !usable;
    } catch (e) {
      log('Exception in User.unUsable : $e');
      return true;
    }
  }

  @override
  bool get usable {
    try {
      return token != null && data != null && data.id != null;
    } catch (e) {
      log('Exception in User.usable : $e');
      return false;
    }
  }
}
