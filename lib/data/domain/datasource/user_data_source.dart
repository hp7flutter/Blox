import 'package:blox/data/blox/builder/blox_builder.dart';
import 'package:blox/data/di/di.dart';
import 'package:blox/data/domain/core/remote_core.dart';
import 'package:blox/data/domain/core/repository_core.dart';
import 'package:blox/data/model/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class UserRemote extends Remote<UserModel> {
  UserRemote() : super(endPoint: 'users', factoryModel: UserModel.fromJson);
  Future<List<UserModel>> dataList() => getData();
}
  
class UserRepository extends Repository<UserModel> {
  UserRepository(super.remote);
  Future<Either<String, List<UserModel>>> dataList() => getData();
}

class UserBlox extends BloxBuilder<UserModel> {
  UserBlox({
    super.key,
    required Widget Function(BuildContext context, List<UserModel> data)
    super.builder,
    super.failure,
    super.postData,
  }) : super(repository: Di.locator.get<Repository<UserModel>>());
}
