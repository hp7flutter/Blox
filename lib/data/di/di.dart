import 'package:blox/data/domain/core/remote_core.dart';
import 'package:blox/data/domain/core/repository_core.dart';
import 'package:blox/data/domain/datasource/user_data_source.dart';
import 'package:blox/data/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class Di {
  static const String baseUrl = 'https://startflutter.ir/api/';
  static final GetIt locator = GetIt.instance;
  static Future<void> setupLocator() async {
    locator.registerSingleton<Dio>(Dio(BaseOptions(baseUrl: baseUrl)));
    locator.registerFactory<Remote<UserModel>>(() => UserRemote());
    locator.registerFactory<Repository<UserModel>>(
      () => UserRepository(locator()),
    );
  }
}
