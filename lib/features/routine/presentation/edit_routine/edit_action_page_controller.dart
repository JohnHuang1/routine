import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:routine/features/routine/application/sra_service.dart';
import 'package:routine/features/routine/domain/action.dart';

import '../../domain/field.dart';

part 'edit_action_page_controller.g.dart';

@riverpod
class EditActionPageController extends _$EditActionPageController {
  @override
  Stream<Action> build(String? id) {
    int? actionId = int.tryParse(id ?? '');
    if (actionId == null) {
      throw ArgumentError.value(id);
      // return returnFuture.value(
      //     EditRoutinePageState(
      //         routine: Routine(id: 0, name: '', actions: []), newRoutine: true)
      // );
    }
    return ref.watch(sraServiceProvider).watchAction(actionId);
  }

  Future<void> setName(String name) async {
    log('EditActionPage setName(): $name');
    final action = state.requireValue;
    await ref.read(sraServiceProvider).setAction(action.setName(name));
  }

  Future<void> addField() async {
    final action = state.requireValue.addField(label: 'New Field');
    await ref.read(sraServiceProvider).setAction(action);
  }

  Future<void> setField(int index,
      {String? label, String? value, FieldType? type}) async{
    final action = state.requireValue;
    await ref.read(sraServiceProvider).setField(action.id, index, label, value, type);
  }
}
