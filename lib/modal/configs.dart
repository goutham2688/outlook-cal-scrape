import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Configs {
  String? binId;
  String? accessKey;
  String? fernetEncryptionKey;
  Configs({
    required this.binId,
    required this.accessKey,
    required this.fernetEncryptionKey,
  });

  bool ifAllValuesExist() {
    if ((binId != null) &&
        (accessKey != null) &&
        (fernetEncryptionKey != null)) {
      return true;
    } else {
      return false;
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'binId': binId,
      'accessKey': accessKey,
      'fernetEncryptionKey': fernetEncryptionKey,
    };
  }

  factory Configs.fromMap(Map<String, dynamic> map) {
    return Configs(
      binId: map['binId'] as String,
      accessKey: map['accessKey'] as String,
      fernetEncryptionKey: map['fernetEncryptionKey'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Configs.fromJson(String source) =>
      Configs.fromMap(json.decode(source) as Map<String, dynamic>);
}
