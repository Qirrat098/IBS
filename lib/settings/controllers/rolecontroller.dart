
import 'package:get/get.dart';
class roleController extends GetxController {
  List<Roleinfo> roles = [];

  void addrole(Roleinfo role) {
    roles.add(role);
    update();
  }

  void removetype(int index) {
    roles.removeAt(index);
    update();
  }
}

class Roleinfo {
  final String name;

  Roleinfo({
    required this.name,


  });
}