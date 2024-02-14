abstract class AbstractEncrypt {
  String encryptAES(String key, String data);
  String decryptAES(String key, String encryptedData);
  String encryptSHA(String data);
  bool verifySHA(String key, String encryptedData);
}

abstract class EncryptDatasource extends AbstractEncrypt {}

abstract class EncryptRepository extends AbstractEncrypt {
  final EncryptDatasource datasource;
  EncryptRepository(this.datasource);
}

abstract class EncryptService extends AbstractEncrypt {}
