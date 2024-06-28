import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:routine/common_widgets/general_app_bar.dart';
import 'package:routine/constants/styling.dart';
import 'package:routine/features/routine/application/sra_service.dart';
import 'package:routine/features/routine/presentation/list_display/routine_list_tile_widget.dart';
import 'package:routine/routing/routes.dart';

import '../schedule_provider.dart';

class ScheduleListPage extends ConsumerWidget {
  const ScheduleListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleAsync = ref.watch(scheduleProvider);
    return Scaffold(
      appBar: GeneralAppBar(title: const Text('Routine')),
      body: scheduleAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) {
          log(err.toString(), stackTrace: stack);
          return Text('Error: $err');
        },
        data: (schedule) => ListView.builder(
          padding: listViewPadding,
          itemCount: schedule.routines.length,
          itemBuilder: (context, index) => Padding(
            padding: listViewItemPadding,
            child: RoutineListTileWidget(
              routineID: schedule.routines[index],
              onClick: () {
                context.push(editRoutinePageRoute(schedule.routines[index]));
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        child: const Icon(Icons.add),
        onPressed: () async {
          final routine = await ref.read(sraServiceProvider).createRoutine();
          await ref.read(sraServiceProvider).setScheduleRoutine(routine.id);
          if (context.mounted) {
            context.push(editRoutinePageRoute(routine.id));
          }
        },
      ),
    );
  }
}
