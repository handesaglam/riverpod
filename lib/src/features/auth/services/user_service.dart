import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vacco/src/features/auth/models/users_model.dart';
import 'package:http/http.dart' as http;


class ApiServices{
  String endpoint = 'https://reqres.in/api/users?page=2';
  Future<List<UserModel>> getUsers() async {
    var response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200){
      final List result = jsonDecode(response.body)['data'];
      return result.map(((e) => UserModel.fromJson(e))).toList();
    }else {
      throw Exception(response.reasonPhrase);
    }
  }
}

final userProvider= Provider<ApiServices>((ref)=>ApiServices());