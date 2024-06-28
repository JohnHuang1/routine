import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:routine/features/routine/data/hive_action_repository.dart';
import 'package:routine/features/routine/data/hive_routine_repository.dart';
import 'package:routine/features/routine/data/hive_schedule_repository.dart';
import 'package:routine/features/routine/data/routine_repository.dart';
import 'package:routine/features/routine/domain/action.dart';
import 'package:routine/features/routine/domain/field.dart';
import 'package:routine/features/routine/domain/routine.dart';
import 'package:routine/features/routine/domain/schedule.dart';
import 'package:routine/features/routine/presentation/list_display/schedule_list_page.dart';
import 'package:routine/routing/go_router.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FieldAdapter());
  Hive.registerAdapter(FieldTypeAdapter());
  Hive.registerAdapter(ActionAdapter());
  Hive.registerAdapter(RoutineImplAdapter());
  Hive.registerAdapter(ScheduleImplAdapter());
  runApp(
    ProviderScope(
      overrides: [
        hiveActionRepositoryProvider.overrideWithValue(
            HiveActionRepository(box: await Hive.openBox(actionRepositoryKey))),
        hiveRoutineRepositoryProvider.overrideWithValue(HiveRoutineRepository(
            box: await Hive.openBox(routineRepositoryKey))),
        hiveScheduleRepositoryProvider.overrideWithValue(HiveScheduleRepository(
            box: await Hive.openBox(scheduleRepositoryKey)))
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Routine',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.cyan, brightness: Brightness.dark),
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      routerConfig: ref.watch(goRouterProvider),
    );
  }
}
