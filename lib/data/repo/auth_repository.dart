import 'package:flutter/material.dart';
import 'package:shop_flutter/common/http_client.dart';
import 'package:shop_flutter/data/auth_info.dart';
import 'package:shop_flutter/data/source/auth_data_source.dart';

final authRepository =
    AuthRepository(dataSource: AuthRemoteDataSource(httpClient: httpClient));

abstract class IAuthRepository {
  Future<void> login(String username, String password);
  Future<void> signUp(String username, String password);
}

class AuthRepository implements IAuthRepository {
  final IAuthDataSource dataSource;

  AuthRepository({required this.dataSource});

  @override
  Future<void> login(String username, String password) async {
    final AuthInfo authInfo = await dataSource.login(username, password);
    debugPrint("access token is: ${authInfo.accessToken}");
  }

  @override
  Future<void> signUp(String username, String password) async {
    try {
      final AuthInfo authInfo = await dataSource.signUp(username, password);
      debugPrint("access token is: " + authInfo.accessToken);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
