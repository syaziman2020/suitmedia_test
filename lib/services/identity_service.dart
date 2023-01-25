import 'package:dio/dio.dart';
import 'package:suitmedia_app/models/identity_model.dart';

class IdentityService {
  Dio dio = Dio();
  Future<IdentityModel> getIdentity(int page) async {
    String url = 'https://reqres.in/api/users?page=';
    try {
      final response = await dio.get("$url$page");
      if (response.statusCode == 200) {
        IdentityModel result = IdentityModel.fromJson(response.data);
        return result;
      } else {
        throw Exception(
            'Get didn\'t work with the code ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
