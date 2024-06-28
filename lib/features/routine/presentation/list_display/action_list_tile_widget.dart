import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:routine/features/routine/domain/action.dart';
import 'package:routine/features/routine/presentation/action_provider.dart';
import 'package:routine/routing/go_router.dart';
import 'package:routine/routing/routes.dart';

class ActionListTileWidget extends ConsumerWidget {
  const ActionListTileWidget({super.key, required this.id});

  final ActionID id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actionAsync = ref.watch(actionProvider(id));
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      child: ListTile(
        leading: Text('id#$id'),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: colorScheme.onSurface),
            borderRadius: BorderRadius.circular(5)
        ),
        title: actionAsync.when(
            data: (action) => Text(action.name),
            error: (err, state) => Text('Error: $err'),
            loading: () => const CircularProgressIndicator()),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            ref.read(goRouterProvider).push(editActionPageRoute(id));
          },
        ),
      )
    );
  }
}
