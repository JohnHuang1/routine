import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:routine/features/routine/application/sra_service.dart';
import 'package:routine/features/routine/domain/routine.dart';

part 'routine_controller.g.dart';

@riverpod
Stream<Routine> routine(RoutineRef ref, RoutineID id) {
  return ref.watch(sraServiceProvider).watchRoutine(id);
}