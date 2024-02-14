import 'package:tradex_wallet_3/domain/entities/abstract_collectible_entity.dart';

abstract class _AbstractStorage<T extends AbstractCollectibleEntity> {
  Future<List<T>> getAll({int limit = 10, int offset = 0});
  Future<T?> getById(int id);
  Future<int> save(T entity);
  Future<List<int>> saveAll(List<T> entities);
  Future<bool> delete(int id);
}

abstract class LocalStorageDatasource<T extends AbstractCollectibleEntity>
    extends _AbstractStorage<T> {}

abstract class LocalStorageRepository<T extends AbstractCollectibleEntity>
    extends _AbstractStorage<T> {
  final LocalStorageDatasource<T> datasource;
  LocalStorageRepository(this.datasource);
}
