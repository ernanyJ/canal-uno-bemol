import 'dart:convert';

String globalToken = '';
int? expDate;

Map<String, dynamic> getJwtData() {
  final parts = globalToken.split('.');
  final payload = parts[1];
  final String normalized = base64Url.normalize(payload);
  final String resp = utf8.decode(base64Url.decode(normalized));
  final Map<String, dynamic> payloadMap = json.decode(resp);

  return payloadMap;
}

DateTime? getExpDate() {
  final Map<String, dynamic> payloadMap = getJwtData();
  final int exp = payloadMap['exp'];
  expDate = exp;
  return DateTime.fromMillisecondsSinceEpoch(exp * 1000);
}
