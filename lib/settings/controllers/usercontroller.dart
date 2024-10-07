import 'package:get/get.dart';

class userController extends GetxController {
  List<User> users = [];

  void adduser(User user) {
    users.add(user);
    update();
  }

  void removeuser(int index) {
    users.removeAt(index);
    update();
  }
}

class User {
  final String name;
  final String email;
  final String role;
  User({
    required this.name,
    required this.email,
    required this.role
  });
}