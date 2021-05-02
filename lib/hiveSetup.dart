import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveSetup {
  Future<Box> initBox(String dbName) async {
    await Hive.initFlutter();

    return this.initHiveDB(dbName, false);
  }

  Future<Box> initHiveDB(String dbName, bool tryFixDB) async {
    try {
      List<int> key = Hive.generateSecureKey();
      Box tokenBox;

      if (!Hive.isBoxOpen(dbName)) {
        tokenBox =
            await Hive.openBox(dbName, encryptionCipher: HiveAesCipher(key));
      } else {
        tokenBox = Hive.box(dbName);
      }

      return tokenBox;
    } catch (_) {
      print('Attention corrupted DB detected. Try to delete the DB file');

      if (!tryFixDB && !kIsWeb) {
        tryFixDB = true;

        await Hive.deleteBoxFromDisk(dbName);

        return await initHiveDB(dbName, tryFixDB);
      } else {
        return null;
      }
    }
  }
}
