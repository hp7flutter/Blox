class ApiException implements Exception {
  int? exCode;
  String? exMessage;

  ApiException({
    this.exCode = 0,
    this.exMessage = 'خطا در برقراری ارتباط با سرور!',
  });
}
