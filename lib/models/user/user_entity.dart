import 'package:equatable/equatable.dart';
import 'package:fennec_desktop/models/user/user_model.dart';

class UserEntity extends Equatable {
  final String name;
  final String birthDay;
  final String email;
  final String tell;
  final String cpf;
  final String rg;
  final String password;
  final String token;
  final String jwtoken;

  const UserEntity({
    required this.name,
    required this.birthDay,
    required this.email,
    required this.tell,
    required this.cpf,
    required this.rg,
    required this.password,
    required this.token,
    required this.jwtoken,
  });

  factory UserEntity.fromModel(UserModel model) => UserEntity(
        name: model.name,
        birthDay: model.birthDay,
        email: model.email,
        tell: model.tell,
        cpf: model.rg,
        rg: model.cpf,
        password: model.password,
        token: model.token,
        jwtoken: model.jwtoken,
      );

  @override
  List<Object> get props => [
        name,
        birthDay,
        email,
        tell,
        cpf,
        rg,
        password,
        token,
        jwtoken,
      ];
}
