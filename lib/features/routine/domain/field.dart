import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:routine/constants/type_id.dart';

part 'field.g.dart';
part 'field.freezed.dart';

@freezed
class Field extends HiveObject with _$Field {
  Field._();

  @HiveType(typeId: TypeId.field, adapterName: 'FieldAdapter')
  factory Field({
    @HiveField(0) required String label,
    @HiveField(1) required String value,
    @HiveField(2) required FieldType type,
  }) = _Field;
}

@HiveType(typeId: TypeId.fieldType)
enum FieldType {
  @HiveField(0) number,
  @HiveField(1) string,
  @HiveField(2) bool
}