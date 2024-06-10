import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine/features/routine/domain/routine.dart';
import 'package:routine/features/routine/presentation/routine_display_controller.dart';

class RoutineListTileWidget extends ConsumerWidget {
  const RoutineListTileWidget({super.key, required this.routineID});

  final RoutineID routineID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routineAsync = ref.watch(routineDisplayControllerProvider(routineID));
    return routineAsync.when(
      data: (routine) => ListTile(
        title: Text(routine.name),
      ),
      error: (err, stack) => ListTile(title: Text('Error: $err')),
      loading: () => const ListTile(leading: CircularProgressIndicator()),
    );
  }
}
