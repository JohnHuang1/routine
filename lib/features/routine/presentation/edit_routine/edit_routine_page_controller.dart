import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:routine/features/routine/application/sra_service.dart';
import 'package:routine/features/routine/domain/routine.dart';
import 'package:routine/routing/go_router.dart';
import 'package:routine/routing/routes.dart';

part 'edit_routine_page_controller.g.dart';

class EditRoutinePageState {
  const EditRoutinePageState({required this.routine, required this.newRoutine});

  final Routine routine;
  final bool newRoutine;
}

@riverpod
class EditRoutinePageController extends _$EditRoutinePageController {
  @override
  Stream<EditRoutinePageState> build(String? id) {
    int? routineId = int.tryParse(id ?? '');
    if (routineId == null) {
      throw ArgumentError.value(id);
      // return returnFuture.value(
      //     EditRoutinePageState(
      //         routine: Routine(id: 0, name: '', actions: []), newRoutine: true)
      // );
    }
    return ref.watch(sraServiceProvider).watchRoutine(routineId).map(
        (routine) => EditRoutinePageState(routine: routine, newRoutine: false));
  }

  Future<void> addAction() async {
    final routine = state.requireValue.routine;
    state = const AsyncValue.loading();
    final action = await ref
        .read(sraServiceProvider)
        .createAction(name: 'New Action', routineId: routine.id);
    await ref
        .read(sraServiceProvider)
        .setRoutineAction(routine.id, action.id, null);
  }

  Future<void> setName(String name) async {
    log('setName(): $name');
    final routine = state.requireValue.routine;
    await ref.read(sraServiceProvider).setRoutine(routine.setName(name));
  }

  Future<void> deleteRoutine(bool deleteActions) async {
    final routine = state.requireValue.routine;
    state = const AsyncValue.loading();
    await ref.read(sraServiceProvider).deleteRoutine(routine.id, deleteActions: deleteActions);
    ref.read(goRouterProvider).go(scheduleListPageRoute());
  }
}
