import 'package:flutter/material.dart';

import '../../domain/field.dart';

class EditableFieldTileWidget extends StatelessWidget {
  EditableFieldTileWidget(
      {super.key,
        required this.field,
        this.onLabelSubmitted,
        this.onFieldTypeChanged,
        this.onValueSubmitted});

  final Field field;
  final void Function(FieldType?)? onFieldTypeChanged;
  final void Function(String)? onValueSubmitted;
  final void Function(String)? onLabelSubmitted;

  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  final typeMap = {
    FieldType.bool: TextInputType.none,
    FieldType.string: TextInputType.text,
    FieldType.number: TextInputType.number
  };

  final displayMap = {
    FieldType.bool: 'Checkbox',
    FieldType.string: 'Text',
    FieldType.number: 'Number'
  };

  @override
  Widget build(BuildContext context) {
    _valueController.text = field.value;
    _labelController.text = field.label;
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      child: ListTile(
        title: TextField(
          onSubmitted: onLabelSubmitted,
          controller: _labelController,
        ),
        subtitle: TextField(
          onSubmitted: onValueSubmitted,
          controller: _valueController,
          keyboardType: typeMap[field.type],
        ),
        trailing: DropdownButton<FieldType>(
          value: field.type,
          items: FieldType.values
              .map((val) => DropdownMenuItem<FieldType>(
              value: val, child: Text(displayMap[val]!)))
              .toList(growable: false),
          onChanged: (FieldType? fieldType) {
            onFieldTypeChanged?.call(fieldType);
          },
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: colorScheme.onSurface),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
