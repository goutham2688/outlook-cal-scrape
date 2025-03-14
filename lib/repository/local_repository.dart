import 'dart:convert';

import '../modal/configs.dart';
import '../modal/data_store_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalRepository {
  final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
  final calKey = 'calData';
  final binKey = 'binId';
  final accKey = 'accessKey';
  final passKey = 'pass';

  Future<Configs> getConfigs() async {
    var value = await Future.wait([
      asyncPrefs.getString(binKey),
      asyncPrefs.getString(accKey),
      asyncPrefs.getString(passKey)
    ]);

    return Configs(
        binId: value[0], accessKey: value[1], fernetEncryptionKey: value[2]);
  }

  setConfigs(Configs data) async {
    // print('configs are saved');
    if (data.binId != null) {
      await asyncPrefs.setString(binKey, data.binId!);
    }
    if (data.accessKey != null) {
      await asyncPrefs.setString(accKey, data.accessKey!);
    }
    if (data.fernetEncryptionKey != null) {
      await asyncPrefs.setString(passKey, data.fernetEncryptionKey!);
    }
  }

  Future<DataStoreModal?> getCalData() async {
    // await asyncPrefs.remove(calKey);
    final String? calStr = await asyncPrefs.getString(calKey);
    if (calStr != null) {
      return DataStoreModal.fromJson(json.decode(calStr));
    }
    return null;
  }

  setCalData(DataStoreModal data) async {
    await asyncPrefs.setString(calKey, json.encode(data.toJson()));
  }
}
