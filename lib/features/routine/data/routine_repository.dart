import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:routine/features/routine/domain/routine.dart';

abstract class RoutineRepository {
  Future<Routine> fetchRoutine(RoutineID id);

  Stream<Routine> watchRoutine(RoutineID id);

  Future<void> setRoutine(Routine routine);
}

final routineRepositoryProvider =
    Provider<RoutineRepository>(throw UnimplementedError());
