import 'package:dio/dio.dart';
import 'package:shop_flutter/data/auth_info.dart';
import 'package:shop_flutter/data/common/constants.dart';
import 'package:shop_flutter/data/common/http_response_validator.dart';

abstract class IAuthDataSource {
  Future<AuthInfo> login(String username, String password);
  Future<AuthInfo> register(String username, String password);
  Future<AuthInfo> refreshToken(String token);
}

class AuthRemoteDataSource
    with HttpResponseValidator
    implements IAuthDataSource {
  final Dio httpClient;

  AuthRemoteDataSource({required this.httpClient});

  @override
  Future<AuthInfo> login(String username, String password) async {
    final response = await httpClient.post("auth/token", data: {
      "grant_type": "password",
      "client_id": 2,
      "client_secret": Constants.clientSecret,
      "username": username,
      "password": password
    });
    validateResponse(response);
    return AuthInfo(
        response.data["access_token"], response.data["refresh_token"]);
  }

  @override
  Future<AuthInfo> refreshToken(String token) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future<AuthInfo> register(String username, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
