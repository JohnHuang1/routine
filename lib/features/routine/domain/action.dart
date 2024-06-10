import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:routine/constants/type_id.dart';
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
  }) = _Action;
}
