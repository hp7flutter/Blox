import 'package:blox/data/domain/core/remote_core.dart';
import 'package:blox/data/domain/utility/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class Repository<T> {
  final Remote<T> remote;
  Repository(this.remote);

  Future<Either<String, List<T>>> getData() async {
    try {
      final List<T> response = await remote.getData();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.exMessage!);
    } catch (ex) {
      return left(ApiException().exMessage!);
    }
  }

  Future<Either<String, T>> postData({
    required Map<String, dynamic> dataMap,
  }) async {
    try {
      final response = await remote.postData(dataMap: dataMap);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.exMessage ?? ApiException().exMessage!);
    }
  }
}
