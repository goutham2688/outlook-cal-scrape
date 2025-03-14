import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:fernet/fernet.dart';
import 'package:http/http.dart' as http;

import '../modal/data_store_modal.dart';
import '../modal/cal_event.dart';
import '../modal/configs.dart';

class ApiRepository {
  Future<DataStoreModal> getLatestData({required Configs configData}) async {
    final data = await _makeAPICall(configData: configData);
    final jsonData = jsonDecode(data);
    final modifiedTimestamp =
        DateTime.fromMillisecondsSinceEpoch(jsonData['timestamp']);
    final startDate = DateTime.parse(jsonData['startDate']);
    final endDate = DateTime.parse(jsonData['endDate']);
    final decodedCsvData = _decodeFernetData(jsonData['data'], configData);
    List<CalEvent> eventListData = [];

    // CSV decoding
    List<List<dynamic>> rowsAsListOfValues =
        const CsvToListConverter().convert(decodedCsvData);

    rowsAsListOfValues.removeAt(0);

    for (final e in rowsAsListOfValues) {
      final cal = CalEvent(
          startTime: DateTime.parse(e[0]),
          endTime: DateTime.parse(e[1]),
          title: e[2]);
      eventListData.add(cal);
    }
    return DataStoreModal(
        lastUpdatedTime: modifiedTimestamp,
        startDate: startDate,
        endDate: endDate,
        eventList: eventListData);
  }

  Future<String> _makeAPICall(
      {String? path, required Configs configData}) async {
    final headers = {
      'X-Access-Key': configData.accessKey!,
      'X-Bin-Meta': 'false',
    };

    if (path != null) {
      headers['X-JSON-Path'] = path;
    }
    final url =
        Uri.parse('https://api.jsonbin.io/v3/b/${configData.binId}/latest');

    final res = await http.get(url, headers: headers);

    final resultStatus = res.statusCode;
    if (resultStatus != 200) {
      throw Exception('ERROR in fetching resultStatus= $resultStatus');
    } else {
      // print('API worked as expected');
    }

    return res.body;
  }

  String _decodeFernetData(String encryptedData, Configs configData) {
    final Fernet f = Fernet(configData.fernetEncryptionKey);
    return utf8.decode(f.decrypt(encryptedData));
  }
}
