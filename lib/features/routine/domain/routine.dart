import 'package:freezed_annotation/freezed_annotation.dart';
import 'action.dart';

part 'routine.freezed.dart';

typedef RoutineID = double;

@freezed
class Routine with _$Routine {
  const factory Routine({
    required RoutineID id,
    required String name,
    required List<ActionID> actions
  }) = _Routine;
}

extension MutableRoutine on Routine {
  Routine insertAction(ActionID id, int pos) {
    final copy = List<ActionID>.from(actions);
    copy.insert(pos, id);
    return copyWith(actions: copy);
  }
}