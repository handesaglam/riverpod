import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../features/auth/controllers/auth_controller.dart';
import '../features/auth/services/auth_service.dart';

import 'constants.dart';
import 'data_state.dart';


final dioProvider = Provider<Dio>(
  (ref) => Dio(
    BaseOptions(
      headers: {
       
        'Prefer': 'return=representation',
      },
      baseUrl: kBaseUrl,
    ),
  ),
);

final dateFormatProvider = Provider((_) {
  initializeDateFormatting();

  return DateFormat('yyyy-MM-dd hh:mm');
});


//Services


final authServiceProvider = Provider<AuthService>(
  (ref) => AuthService(ref.read(dioProvider)),
);

//Notifiers

final authNotifier = StateNotifierProvider<AuthController, DataState>(
  (ref) => AuthController(ref.read(authServiceProvider)),
);
