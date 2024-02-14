import 'package:tradex_wallet_3/domain/entities/blockchain_network.dart';

class KeypairAccountResponseDTO {
  final String publicKey;
  final String privateKey;
  final List<BlockchainIdentity> blockchainIdentities;

  KeypairAccountResponseDTO({
    required this.publicKey,
    required this.privateKey,
    required this.blockchainIdentities,
  });
}
