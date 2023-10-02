import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vacco/src/Helper/SharedPrefencesHelper.dart';

import '../models/user_model.dart';

class AuthService {
  final Dio _dio;

  AuthService(this._dio);

  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/api/login',
        
        data: <String, dynamic>{'email': email, 'password': password},
      );

  
      if (response.statusCode == 200) {
        
        SharedPrefencesHelper().setToken(response.data['token']);
        final tokensProvider = Provider<String>((_) => response.data['token']);


      
        return UserModel.fromJson(response.data);

      } else {
        throw Exception('An error occurred');
      }
    } on DioError catch (e) {
      throw Exception(e.response!.data['error_description']);
    } catch (e) {
      throw Exception("Couldn't login. Is the device online?");
    }
  }




  
}
