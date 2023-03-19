import '../database/app_database.dart';

class ModelsUsers {
  String futureResult = '';
  Future<String> insertData(String name, String wife, String address) async {
    futureResult = await AppDatabase().registerData(name, wife, address);
    return futureResult;
  }
}
