class UserProfileService {
  static String name = "John Doe";
  static String email = "john.doe@example.com";

  static void update({
    required String newName,
    required String newEmail,
  }) {
    name = newName;
    email = newEmail;
  }
}
