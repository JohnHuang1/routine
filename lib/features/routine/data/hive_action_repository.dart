import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:routine/features/routine/data/action_repository.dart';
import 'package:routine/features/routine/domain/action.dart';
import 'package:rxdart/rxdart.dart';

import '../domain/field.dart';

const actionRepositoryKey = 'action';

class HiveActionRepository implements ActionRepository {
  HiveActionRepository({required this.box});

  final Box<Action> box;

  @override
  Future<Action> addAction(Action action) async {
    final id = await box.add(action);
    final copy = action.setId(id);
    box.put(id, copy);
    return copy;
  }

  @override
  Future<Action> fetchAction(ActionID id) {
    final routine = box.get(id);
    if (routine == null) {
      throw Exception('HiveActionRepository actionID $id = null');
    }
    return Future.value(routine);
  }

  @override
  Future<void> setAction(Action action) {
    return box.put(action.id, action);
  }

  @override
  Future<void> setField(ActionID id, int index, String? label, String? value, FieldType? type) async {
    final action = box.get(id);
    if(action == null) throw Exception('HiveActionRepository setField() bad id=$id');
    final list = List<Field>.from(action.fields);
    var field = list[index];
    if(label != null) field = field.copyWith(label: label);
    if(value != null) field = field.copyWith(value: value);
    if(type != null) field = field.copyWith(type: type);
    list[index] = field;
    return box.put(id, action.copyWith(fields: list));
  }

  @override
  Stream<Action> watchAction(ActionID id) {
    final action = box.get(id);
    if(action == null) throw Exception('HiveActionRepository watchAction() bad id=$id');
    return box.watch(key: id).map((event) => event.value as Action).startWith(action);
  }

  @override
  Future<void> deleteAction(ActionID id) {
    return box.delete(id);
  }
}

final hiveActionRepositoryProvider =
    Provider<ActionRepository>((ref) => throw UnimplementedError());
