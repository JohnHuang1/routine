import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine/common_widgets/general_app_bar.dart';
import 'package:routine/features/routine/presentation/edit_routine/edit_list_view.dart';
import 'package:routine/features/routine/presentation/edit_routine/edit_routine_page_controller.dart';
import 'package:routine/features/routine/presentation/list_display/action_list_tile_widget.dart';
import 'package:routine/features/routine/presentation/routine_controller.dart';

import '../../../../routing/go_router.dart';
import '../../application/sra_service.dart';
import '../../domain/routine.dart';

class EditRoutinePage extends ConsumerWidget {
  EditRoutinePage({super.key, required this.id});

  final String? id;
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(editRoutinePageControllerProvider(id));
    return stateAsync.when(
      data: (state) {
        _nameController.text = state.routine.name;
        return Scaffold(
          appBar: GeneralAppBar(
            title: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Routine'),
              ),
              controller: _nameController,
              onSubmitted: (val) {
                ref
                    .read(editRoutinePageControllerProvider(id).notifier)
                    .setName(val);
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: IconButton(
                  onPressed: () => showDeleteDialog(context, ref),
                  icon: const Icon(Icons.delete),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: EditListView(
              itemCount: state.routine.actions.length,
              itemBuilder: (_, index) =>
                  ActionListTileWidget(id: state.routine.actions[index]),
              button: FilledButton.icon(
                onPressed: () {
                  ref
                      .read(editRoutinePageControllerProvider(id).notifier)
                      .addAction();
                },
                label: const Text('Add Action'),
                icon: const Icon(Icons.add),
              ),
            ),
          ),
        );
      },
      error: (error, state) => Scaffold(
        body: Text('Error: $error'),
      ),
      loading: () => const Scaffold(
        body: CircularProgressIndicator(),
      ),
    );
  }

  void showDeleteDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Routine'),
        content: const Text(
            'Delete associated actions as well? (only actions solely associated with this routine will be deleted)'),
        actions: [
          FilledButton(
              onPressed: () {
                ref.read(editRoutinePageControllerProvider(id).notifier).deleteRoutine(true);
              },
              child: const Text('Delete Routine and Actions')),
          FilledButton(
              onPressed: () {
                ref.read(editRoutinePageControllerProvider(id).notifier).deleteRoutine(false);
              }, child: const Text('Delete Only Routine')),
          OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel')),
        ],
      ),
    );
  }
}
