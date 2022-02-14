import 'package:fennec_desktop/models/user/user_model.dart';

abstract class LocalDataSource {
  Future<UserModel?> deviceUser();
}
