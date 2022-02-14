import 'package:fennec_desktop/models/user/user_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required String name,
    required String birthDay,
    required String email,
    required String tell,
    required String cpf,
    required String rg,
    required String password,
    required String token,
    required String jwtoken,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromEntity(UserEntity user) => UserModel(
        name: user.name,
        birthDay: user.birthDay,
        email: user.email,
        tell: user.tell,
        cpf: user.cpf,
        rg: user.rg,
        password: user.password,
        token: user.token,
        jwtoken: user.jwtoken,
      );
}
