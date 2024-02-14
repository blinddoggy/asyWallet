import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tradex_wallet_3/features/encrypt/domain/abstract_encrypt.dart';
import 'package:tradex_wallet_3/features/encrypt/infrastructure/datasources/encrypt_datasource_impl.dart';
import 'package:tradex_wallet_3/features/encrypt/infrastructure/encrypt_repository_impl.dart';

final encryptProvider = Provider<EncryptRepository>(
    (ref) => EncryptRepositoryImpl(EncryptDatasourceImpl()));
