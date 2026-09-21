import 'package:blox/data/di/di.dart';
import 'package:blox/data/domain/utility/api_collections.dart';
import 'package:blox/data/domain/utility/api_exception.dart';
import 'package:dio/dio.dart';

abstract class Remote<T> {
  Remote({required this.endPoint, required this.factoryModel});

  String endPoint;
  T Function(Map<String, dynamic> json) factoryModel;

  final Dio dio = Di.locator.get<Dio>();

  Future<List<T>> getData() async {
    try {
      final Response<dynamic> response = await dio.get(
        ApiCollections.collection(endPoint),
      );
      final data = response.data;
      final List<dynamic> items = data['items'];
      final List<T> dataList = items
          .map<T>((json) => factoryModel(json as Map<String, dynamic>))
          .toList();
      print(dataList);
      return dataList;
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.unknown &&
          ex.message?.contains('CERTIFICATE_VERIFY_FAILED') == true) {
        print('SSL Error! $T data');
      } else {
        print('Network Error!: $T data ${ex.message}');
      }
      throw ApiException(
        exCode: ex.response?.statusCode,
        exMessage: ex.response?.statusMessage,
      );
    } catch (ex) {
      throw ApiException();
    }
  }

  Future<T> postData({required Map<String, dynamic> dataMap}) async {
    try {
      final Response<dynamic> response = await dio.post(
        endPoint,
        data: dataMap,
        options: Options(contentType: 'multipart/form-data'),
      );
      return factoryModel(response.data as Map<String, dynamic>);
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.unknown &&
          ex.message?.contains('CERTIFICATE_VERIFY_FAILED') == true) {
        print('SSL Error! $T data');
      } else {
        print('Network Error!: $T data ${ex.message}');
      }
      throw ApiException(
        exCode: ex.response?.statusCode,
        exMessage: ex.response?.statusMessage,
      );
    } catch (ex) {
      throw ApiException();
    }
  }
}
