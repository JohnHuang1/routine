import 'package:routine/features/routine/domain/action.dart';

import '../domain/field.dart';

abstract class ActionRepository {
  Future<Action> fetchAction(ActionID id);
  Future<Action> addAction(Action action);
  Future<void> setAction(Action action);
  Future<void> deleteAction(ActionID id);
  Stream<Action> watchAction(ActionID id);
  Future<void> setField(ActionID id, int index, String? label, String? value,
      FieldType? type);
}