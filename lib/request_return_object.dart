class NetworkCallerReturnObject {
  bool success;
  dynamic returnValue;
  String errorMessage;
  int responseCode;

  NetworkCallerReturnObject(
      {required this.errorMessage,
      required this.returnValue,
      required this.success,
      required this.responseCode});
}
