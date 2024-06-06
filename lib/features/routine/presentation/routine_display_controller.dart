import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:routine/features/routine/application/routine_service.dart';
import '../domain/routine.dart';

part 'routine_display_controller.g.dart';

@riverpod
Future<Routine> routineDisplayController(
    RoutineDisplayControllerRef ref, RoutineID id) {
  return ref.watch(routineServiceProvider).fetchRoutine(id);
}
