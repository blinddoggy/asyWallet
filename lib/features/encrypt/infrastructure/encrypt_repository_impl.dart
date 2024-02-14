import 'package:tradex_wallet_3/features/encrypt/domain/abstract_encrypt.dart';

class EncryptRepositoryImpl extends EncryptRepository {
  EncryptRepositoryImpl(super.datasource);

  @override
  String encryptAES(String key, String data) {
    return datasource.encryptAES(key, data);
  }

  @override
  String decryptAES(String key, String encryptedData) {
    return datasource.decryptAES(key, encryptedData);
  }

  @override
  String encryptSHA(String data) {
    return datasource.encryptSHA(data);
  }

  @override
  bool verifySHA(String key, String encryptedData) {
    return datasource.verifySHA(key, encryptedData);
  }
}
