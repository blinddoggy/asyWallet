import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tradex_wallet_3/domain/entities/_entities.dart';
// import 'package:tradex_wallet_3/storage/domain/datasource/local_storage_datasource.dart';
import 'package:tradex_wallet_3/domain/entities/abstract_collectible_entity.dart';
import 'package:tradex_wallet_3/features/storage/domain/abstract_storage.dart';

class IsarLocalStorageDatasource<T extends AbstractCollectibleEntity>
    extends LocalStorageDatasource<T> {
  late Future<Isar> db;
  static const List<CollectionSchema> collectionSchemas = [
    AccountSchema,
    AssetSchema,
    BlockchainNetworkSchema,
    NFTSchema,
    NotificationSchema,
    PreferencesSchema,
    TransactionSchema,
    UserSchema,
    WalletSchema,
  ];

  IsarLocalStorageDatasource() {
    db = openIsarDB();
  }

  Future<Isar> openIsarDB() async {
    final dir = await getApplicationDocumentsDirectory();
    // try {
    if (Isar.instanceNames.isEmpty) {
      return Isar.openSync(
        collectionSchemas,
        inspector: true,
        directory: dir.path,
      );
    }
    return Future.value(Isar.getInstance());
    // } catch (e) {
    //   print('error opening isar $e');
    // }
  }

  @override
  Future<List<T>> getAll({limit = 10, offset = 0}) async {
    final isar = await db;

    return await isar
        .collection<T>()
        .where()
        .offset(offset)
        .limit(limit)
        .findAll();
  }

  @override
  Future<T?> getById(int id) async {
    final isar = await db;
    return isar.collection<T>().get(id);
  }

  @override
  Future<int> save(T entity) async {
    final isar = await db;
    return await isar.writeTxn(() async {
      return await isar.collection<T>().put(entity);
    });
  }

  @override
  Future<bool> delete(int id) async {
    final isar = await db;
    return await isar.writeTxn(() async {
      return await isar.collection<T>().delete(id);
    });
  }

  @override
  Future<List<int>> saveAll(List<T> entities) async {
    final isar = await db;
    return await isar.writeTxn(() async {
      return await isar.collection<T>().putAll(entities);
    });
  }
}
