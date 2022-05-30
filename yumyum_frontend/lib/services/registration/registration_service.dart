abstract class RegistrationService {
  Future<int> register(
      String name, String username, String password, String email, String address);
  Future<String> checkUsername(String username, String email);
}
