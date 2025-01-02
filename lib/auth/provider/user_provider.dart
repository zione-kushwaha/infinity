import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../authentication/repository/user_data_service.dart';
import '../model/user_model.dart';

final currentUserProvider = FutureProvider<UserModel>((ref) async {
  final UserModel user =
      await ref.watch(userDataServiceProvider).fetchCurrentUserData();
  return user;
});
