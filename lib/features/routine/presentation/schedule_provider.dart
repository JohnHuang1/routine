import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:routine/features/routine/application/sra_service.dart';
import 'package:routine/features/routine/domain/schedule.dart';

part 'schedule_provider.g.dart';

@riverpod
Stream<Schedule> schedule(ScheduleRef ref){
  return ref.watch(sraServiceProvider).watchSchedule();
}
