import 'package:isar/isar.dart';
import 'package:tradex_wallet_3/domain/entities/abstract_collectible_entity.dart';

part 'blockchain_network.g.dart';

@collection
class BlockchainNetwork extends AbstractCollectibleEntity {
  final int id;
  @enumerated
  final BlockchainIdentity identity;
  final String name;
  final String nodeUrl;
  final String iconUrl;
  final String nativeCurrency;
  final String contractAddress;
  final String? explorerUrl;
  final String? websiteUrl;
  final int? chainId;
  final int? decimals;
  final List<String> supportedTokens;

  BlockchainNetwork({
    required this.id,
    required this.identity,
    required this.name,
    required this.nodeUrl,
    required this.iconUrl,
    this.websiteUrl,
    this.decimals,
    this.chainId,
    this.explorerUrl,
    required this.nativeCurrency,
    required this.contractAddress,
    this.supportedTokens = const [],
  });

  @override
  String toString() {
    return '[Network: $name ] ';
  }
}

enum BlockchainIdentity {
  mumbai,
  goerli,
  bitcoin,
  bnb,
  ethereum,
  polygon,
  solana,
  tron,
}

const evmNetworks = [
  BlockchainIdentity.ethereum,
  BlockchainIdentity.polygon,
  BlockchainIdentity.bnb,
  BlockchainIdentity.mumbai,
  BlockchainIdentity.goerli,
];
