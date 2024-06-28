import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:routine/constants/type_id.dart';
import 'package:routine/features/routine/domain/routine.dart';
import 'field.dart';

part 'action.freezed.dart';
part 'action.g.dart';

typedef ActionID = int;

@freezed
class Action extends HiveObject with _$Action {
  Action._();

  @HiveType(typeId: TypeId.action, adapterName: 'ActionAdapter')
  factory Action({
    @HiveField(0) required ActionID id,
    @HiveField(1) required String name,
    @HiveField(2) required List<Field> fields,
    @HiveField(3) required List<RoutineID> routines,
  }) = _Action;
}

extension MutableAction on Action {
  Action setId(ActionID id) {
    return copyWith(id: id);
  }

  Action setName(String name) {
    return copyWith(name: name);
  }

  Action addField({String label = 'Field', String value = '', FieldType type = FieldType.bool}) {
    final list = List<Field>.from(fields);
    list.add(Field(label: label, value: value, type: type));
    return copyWith(fields: list);
  }
}