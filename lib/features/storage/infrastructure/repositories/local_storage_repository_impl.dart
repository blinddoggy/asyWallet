import 'package:tradex_wallet_3/features/storage/domain/abstract_storage.dart';
// import 'package:tradex_wallet_3/storage/domain/datasource/local_storage_datasource.dart';
import 'package:tradex_wallet_3/domain/entities/abstract_collectible_entity.dart';
// import 'package:tradex_wallet_3/storage/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl<T extends AbstractCollectibleEntity>
    extends LocalStorageRepository<T> {
  LocalStorageRepositoryImpl(super.datasource);

  @override
  Future<List<T>> getAll({int limit = 10, int offset = 0}) {
    return datasource.getAll(offset: offset, limit: limit);
  }

  @override
  Future<T?> getById(int id) {
    return datasource.getById(id);
  }

  @override
  Future<int> save(T entity) {
    return datasource.save(entity);
  }

  @override
  Future<bool> delete(int id) {
    return datasource.delete(id);
  }

  @override
  Future<List<int>> saveAll(List<T> entities) {
    return datasource.saveAll(entities);
  }
}
