import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:routine/features/routine/data/routine_repository.dart';
import 'package:routine/features/routine/domain/routine.dart';
import 'package:rxdart/rxdart.dart';

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
    return box.put(routine.id, routine);
  }

  @override
  Stream<Routine> watchRoutine(RoutineID id) {
    // if(box.containsKey(id)) throw Exception('HiveRepositoryError: watchRoutine bad id=$id');
    return box.watch(key: id).map((event) => event.value as Routine).startWith(box.get(id)!);
  }

  @override
  Future<Routine> addRoutine(Routine routine) async {
    final id = await box.add(routine);
    final copy = routine.copyWith(id: id);
    box.put(id, copy);
    return copy;
  }

  @override
  Future<void> deleteRoutine(RoutineID id) {
    return box.delete(id);
  }
}

final hiveRoutineRepositoryProvider = Provider<RoutineRepository>(
  (ref) => throw UnimplementedError(),
);
