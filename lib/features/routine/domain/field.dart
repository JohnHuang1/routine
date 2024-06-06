import 'package:freezed_annotation/freezed_annotation.dart';

part 'field.freezed.dart';

@freezed
class Field with _$Field {
  const factory Field({
    required String label,
    required String value,
    required FieldType type,
  }) = _Field;
}

enum FieldType { number, string, bool }
