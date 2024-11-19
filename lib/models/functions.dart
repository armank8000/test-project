import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecuredStorage {
  String myKey;
  String? myValue;
  SecuredStorage({required this.myKey, this.myValue});
  final prefs = const FlutterSecureStorage();
  saveData() async {
    prefs.write(key: myKey, value: myValue);
  }

  getData() async {
    return prefs.read(
      key: myKey,
    );
  }

  deleteData() async {
    prefs.delete(
      key: myKey,
    );
  }
}
