import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:routine/features/routine/data/routine_repository.dart';
import 'package:routine/features/routine/domain/routine.dart';

const routineRepositoryKey = 'routine';

class HiveRoutineRepository implements RoutineRepository {
  HiveRoutineRepository({required this.box});

  Box<Routine> box;

  @override
  Future<Routine> fetchRoutine(RoutineID id) {
    final routine = box.get(id);
    if (routine == null) {
      throw Exception('HiveRoutineRepository fetchRoutine $id = null');
    }
    return Future.value(routine);
  }

  @override
  Future<void> setRoutine(Routine routine) {
    box.put(routine.id, routine);
    return Future.value();
  }

  @override
  Stream<Routine> watchRoutine(RoutineID id) {
    // TODO: implement watchRoutine
    throw UnimplementedError('WatchRoutine');
  }

  @override
  Future<Routine> addRoutine(Routine routine) async {
    final id = await box.add(routine);
    final copy = routine.copyWith(id: id);
    box.put(id, copy);
    return copy;
  }
}

final hiveRoutineRepositoryProvider = Provider<RoutineRepository>(
  (ref) => throw UnimplementedError(),
);
