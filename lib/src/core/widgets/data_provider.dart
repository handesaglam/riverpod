import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vacco/src/features/auth/models/users_model.dart';
import 'package:vacco/src/features/auth/services/user_service.dart';

final userDataProvider = FutureProvider<List<UserModel>>((ref) async {
  return ref.watch(userProvider).getUsers();
});