import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine/features/routine/domain/routine.dart';
import 'package:routine/features/routine/presentation/routine_controller.dart';

class RoutineListTileWidget extends ConsumerWidget {
  const RoutineListTileWidget(
      {super.key, required this.routineID, this.onClick});

  final RoutineID routineID;
  final void Function()? onClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routineAsync = ref.watch(routineProvider(routineID));
    final colorScheme = Theme.of(context).colorScheme;
    return routineAsync.when(
      loading: () => const ListTile(
        title: CircularProgressIndicator(),
      ),
      error: (err, state) => ListTile(title: Text('err: $err')),
      data: (routine) => ListTile(
        leading: Text('id: $routineID'),
        title: Text(routine.name),
        onTap: onClick,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: colorScheme.onSurface),
          borderRadius: BorderRadius.circular(5),
        )
      ),
    );
  }
}
