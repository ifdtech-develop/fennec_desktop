// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      name: json['name'] as String,
      birthDay: json['birthDay'] as String,
      email: json['email'] as String,
      tell: json['tell'] as String,
      cpf: json['cpf'] as String,
      rg: json['rg'] as String,
      password: json['password'] as String,
      token: json['token'] as String,
      jwtoken: json['jwtoken'] as String,
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'birthDay': instance.birthDay,
      'email': instance.email,
      'tell': instance.tell,
      'cpf': instance.cpf,
      'rg': instance.rg,
      'password': instance.password,
      'token': instance.token,
      'jwtoken': instance.jwtoken,
    };
