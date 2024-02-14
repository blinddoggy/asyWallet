import 'package:tradex_wallet_3/domain/entities/_entities.dart';

class PortfolioDTO {
  final Wallet? wallet;
  final BlockchainNetwork? blockchainNetwork;
  final Account? account;
  final List<Asset> assets;

  PortfolioDTO({
    this.wallet,
    this.blockchainNetwork,
    this.account,
    this.assets = const [],
  });

  PortfolioDTO copyWith({
    Wallet? wallet,
    BlockchainNetwork? blockchainNetwork,
    Account? account,
    List<Asset>? assets,
  }) =>
      PortfolioDTO(
        account: account ?? this.account,
        assets: assets ?? this.assets,
        blockchainNetwork: blockchainNetwork ?? this.blockchainNetwork,
      );
}
