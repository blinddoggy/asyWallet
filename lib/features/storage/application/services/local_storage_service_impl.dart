// import 'package:tradex_wallet_3/domain/entities/abstract_collectible_entity.dart';
// import 'package:tradex_wallet_3/storage/domain/abstract_storage.dart';
// // import 'package:tradex_wallet_3/storage/domain/repositories/local_storage_repository.dart';
// // import 'package:tradex_wallet_3/storage/domain/services/local_storage_service.dart';

// class LocalStorageServiceImpl<T extends AbstractCollectibleEntity>
//     extends LocalStorageService<T> {
//   final LocalStorageRepository _localStorageRepository;

//   LocalStorageServiceImpl(this._localStorageRepository);
//   // @override
//   // Future<List<T>> getAll() async {
//   //   final List<AbstractCollectibleEntity> entities =
//   //       await _localStorageRepository.getAll();
//   //   return entities.whereType<T>().toList();
//   // }

//   @override
//   Future<List<T>> getAll({int limit = 10, int offset = 0}) async {
//     final List<AbstractCollectibleEntity> entities =
//         await _localStorageRepository.getAll();
//     return entities.whereType<T>().toList();
//   }

//   @override
//   Future<T?> getById(int id) async {
//     final AbstractCollectibleEntity? entity =
//         await _localStorageRepository.getById(id);
//     return entity as T?;
//   }

//   @override
//   Future<int> save(AbstractCollectibleEntity entity) async {
//     return await _localStorageRepository.save(entity as T);
//   }

//   @override
//   Future<bool> delete(int id) async {
//     return await _localStorageRepository.delete(id);
//   }
// }
