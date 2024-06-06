import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine/features/routine/presentation/list_display/routine_list_tile_widget.dart';
import 'package:routine/features/routine/presentation/schedule_display_controller.dart';

class ScheduleDisplayWidget extends ConsumerWidget {
  const ScheduleDisplayWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleAsync = ref.watch(scheduleDisplayControllerProvider);
    return scheduleAsync.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
      data: (schedule) => ListView.builder(
        itemCount: schedule.routines.length,
        itemBuilder: (context, index) => RoutineListTileWidget(
          routineID: schedule.routines[index],
        ),
      ),
    );
  }
}
