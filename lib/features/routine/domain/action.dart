import 'package:freezed_annotation/freezed_annotation.dart';
import 'field.dart';

part 'action.freezed.dart';

typedef ActionID = double;

@freezed
class Action with _$Action{
  const factory Action({
    required ActionID id,
    required String name,
    required List<Field> fields,
  }) = _Action;
}
