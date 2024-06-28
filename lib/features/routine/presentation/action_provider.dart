import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:routine/features/routine/application/sra_service.dart';
import '../domain/action.dart';

part 'action_provider.g.dart';

@riverpod
Stream<Action> action(
    ActionRef ref, ActionID id) {
  return ref.watch(sraServiceProvider).watchAction(id);
}
