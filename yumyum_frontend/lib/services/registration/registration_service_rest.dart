import 'package:yumyumfyp/app/dependencies.dart';

import 'registration_service.dart';
import '../rest.dart';

class RegistrationServiceRest implements RegistrationService {
  final rest = dependency<RestService>();

  Future<String> checkUsername(String username, String email) async {
    final result = await rest.get('registration?' +
        Uri(queryParameters: {"username": username, "email": email}).query);
    return result;
  }

  Future<int> register(
      String name, String username, String password, String email, String address) async {
    final result = await rest.post('register', data: {
      'name': name,
      'username': username,
      'password': password,
      'email': email,
      'address': address
    });
    return result['isRegistered'];
  }
}
