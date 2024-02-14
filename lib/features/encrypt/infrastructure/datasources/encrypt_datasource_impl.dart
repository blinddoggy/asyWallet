import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

import 'package:tradex_wallet_3/features/encrypt/domain/abstract_encrypt.dart';

class EncryptDatasourceImpl extends EncryptDatasource {
  final iv = IV.fromLength(16);

  @override
  String encryptAES(String key, String data) {
    final shaKey = encryptSHA(key).substring(0, 32);
    final secretKey = Key.fromUtf8(shaKey);
    final encrypter = Encrypter(AES(secretKey));
    final encryptedData = encrypter.encrypt(data, iv: iv);
    return encryptedData.base64;
  }

  @override
  String decryptAES(String key, String encryptedData) {
    final shaKey = encryptSHA(key).substring(0, 32);
    final secretKey = Key.fromUtf8(shaKey);
    final encrypter = Encrypter(AES(secretKey));
    final decryptedData = encrypter.decrypt64(encryptedData, iv: iv);
    return decryptedData;
  }

  @override
  String encryptSHA(String data) {
    final bytes = utf8.encode(data);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  bool verifySHA(String key, String encryptedData) {
    return encryptSHA(key) == encryptedData;
  }
}
