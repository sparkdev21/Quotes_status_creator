import 'dart:async';

import 'package:http/http.dart';

class HttpClient {
  HttpClient._privateConstructor();

  static final HttpClient _instance = HttpClient._privateConstructor();

  factory HttpClient() {
    return _instance;
  }

  Future<dynamic> getRequest(Uri path) async {
    Response response;

    response = await get(path);
    return response;
  }
  // Future<dynamic> getRequest(Uri path) async {
  //   Response response;

  //   try {
  //     response = await get(path);
  //     final statusCode = response.statusCode;
  //     if (statusCode >= 200 && statusCode < 299) {
  //       if (response.body.isEmpty) {
  //         return <dynamic>[];
  //       } else {
  //         return jsonDecode(response.body);
  //       }
  //     } else if (statusCode >= 400 && statusCode < 500) {
  //       throw ClientErrorException();
  //     } else if (statusCode >= 500 && statusCode < 600) {
  //       throw ServerErrorException();
  //     } else {
  //       throw UnknownException();
  //     }
  //   } on SocketException {
  //     throw ConnectionException();
  //   }
  // }
}
