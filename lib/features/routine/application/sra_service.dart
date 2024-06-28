import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine/features/routine/data/action_repository.dart';
import 'package:routine/features/routine/data/hive_action_repository.dart';
import 'package:routine/features/routine/data/hive_routine_repository.dart';
import 'package:routine/features/routine/data/hive_schedule_repository.dart';
import 'package:routine/features/routine/data/routine_repository.dart';
import 'package:routine/features/routine/data/schedule_repository.dart';
import 'package:routine/features/routine/domain/action.dart';
import 'package:routine/features/routine/domain/routine.dart';
import 'package:routine/features/routine/domain/schedule.dart';

import '../domain/field.dart';

class SraService {
  SraService({
    required ActionRepository actionRepository,
    required RoutineRepository routineRepository,
    required ScheduleRepository scheduleRepository,
  })  : _scheduleRepository = scheduleRepository,
        _routineRepository = routineRepository,
        _actionRepository = actionRepository;

  final ActionRepository _actionRepository;
  final RoutineRepository _routineRepository;
  final ScheduleRepository _scheduleRepository;

  Future<Schedule> fetchSchedule() async {
    return _scheduleRepository.fetchSchedule();
  }

  Stream<Schedule> watchSchedule() {
    return _scheduleRepository.watchSchedule();
  }

  Future<void> setScheduleRoutine(RoutineID id) async {
    final schedule = await _scheduleRepository.fetchSchedule();
    final updated = schedule.addRoutine(id);
    await _scheduleRepository.setSchedule(updated);
  }

  Future<void> deleteScheduleRoutine(RoutineID id) async {
    final schedule = await _scheduleRepository.fetchSchedule();
    final updated = schedule.deleteRoutine(id);
    await _scheduleRepository.setSchedule(updated);
  }

  Future<void> setRoutine(Routine routine) {
    return _routineRepository.setRoutine(routine);
  }

  Future<void> setRoutineAction(
      RoutineID routineId, ActionID actionId, int? pos) async {
    final routine = await _routineRepository.fetchRoutine(routineId);
    await _routineRepository.setRoutine(routine.insertAction(actionId, pos));
  }

  Future<Routine> fetchRoutine(RoutineID id) async {
    return _routineRepository.fetchRoutine(id);
  }

  Stream<Routine> watchRoutine(RoutineID id) {
    return _routineRepository.watchRoutine(id);
  }

  Future<void> deleteRoutine(RoutineID id, {bool deleteActions = false}) async {
    if (deleteActions) {
      final actionSet =
          (await _routineRepository.fetchRoutine(id)).actions.toSet();
      for (final id in actionSet) {
        _actionRepository.fetchAction(id).then((action) {
          if (action.routines.length > 1) return;
          _actionRepository.deleteAction(id);
        });
      }
    }
    return Future.wait([
      _routineRepository.deleteRoutine(id),
      deleteScheduleRoutine(id),
    ]).then((_) {});
  }

  Future<Action> fetchAction(ActionID id) async {
    return _actionRepository.fetchAction(id);
  }

  Stream<Action> watchAction(ActionID id) {
    return _actionRepository.watchAction(id);
  }

  Future<Action> createAction(
      {String? name, List<Field>? fields, RoutineID? routineId}) async {
    return _actionRepository.addAction(Action(
        id: 0,
        name: name ?? '',
        fields: fields ?? [],
        routines: routineId != null ? [routineId] : []));
  }

  Future<void> setAction(Action action) async {
    return _actionRepository.setAction(action);
  }

  Future<void> setField(ActionID id, int index, String? label, String? value,
      FieldType? type) async {
    return _actionRepository.setField(id, index, label, value, type);
  }

  Future<Routine> createRoutine(
      {String? name, List<RoutineID>? actions}) async {
    return _routineRepository
        .addRoutine(Routine(id: 0, name: name ?? '', actions: actions ?? []));
  }
}

final sraServiceProvider = Provider<SraService>((ref) {
  return SraService(
      actionRepository: ref.watch(hiveActionRepositoryProvider),
      routineRepository: ref.watch(hiveRoutineRepositoryProvider),
      scheduleRepository: ref.watch(hiveScheduleRepositoryProvider));
});
