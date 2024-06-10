import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine/features/routine/data/hive_routine_repository.dart';
import 'package:routine/features/routine/data/routine_repository.dart';
import 'package:routine/features/routine/domain/routine.dart';

class RoutineService {
  RoutineService({
    required this.routineRepository,
  });

  final RoutineRepository routineRepository;

  Future<Routine> fetchRoutine(RoutineID id) async {
    return routineRepository.fetchRoutine(id);
  }
}

final routineServiceProvider = Provider<RoutineService>((ref) {
  return RoutineService(
      routineRepository: ref.watch(hiveRoutineRepositoryProvider));
});
