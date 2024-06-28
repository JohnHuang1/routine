import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine/common_widgets/general_app_bar.dart';
import 'package:routine/features/routine/domain/field.dart';
import 'package:routine/features/routine/presentation/edit_routine/edit_action_page_controller.dart';
import 'package:routine/features/routine/presentation/edit_routine/edit_routine_page_controller.dart';

import 'edit_list_view.dart';
import 'editable_field_tile_widget.dart';

class EditActionPage extends ConsumerWidget {
  EditActionPage({super.key, required this.id});

  final String? id;
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(editActionPageControllerProvider(id));
    return stateAsync.when(
      data: (state) {
        _nameController.text = state.name;
        return Scaffold(
          appBar: GeneralAppBar(
            title: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Action'),
              ),
              controller: _nameController,
              onSubmitted: (val) {
                ref
                    .read(editActionPageControllerProvider(id).notifier)
                    .setName(val);
              },
            ),
          ),
          body: SafeArea(
            child: EditListView(
              itemCount: state.fields.length,
              itemBuilder: (_, index) => EditableFieldTileWidget(
                field: state.fields[index],
                onFieldTypeChanged: (fieldType) {
                  ref
                      .read(editActionPageControllerProvider(id).notifier)
                      .setField(index, type: fieldType);
                },
                onLabelSubmitted: (label) {
                  ref
                      .read(editActionPageControllerProvider(id).notifier)
                      .setField(index, label: label);
                },
                onValueSubmitted: (value) {
                  ref
                      .read(editActionPageControllerProvider(id).notifier)
                      .setField(index, value: value);
                },
              ),
              button: FilledButton.icon(
                onPressed: () {
                  ref
                      .read(editActionPageControllerProvider(id).notifier)
                      .addField();
                },
                label: const Text('Add Field'),
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
}