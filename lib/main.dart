import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:routine/features/routine/application/routine_service.dart';
import 'package:routine/features/routine/data/hive_routine_repository.dart';
import 'package:routine/features/routine/data/hive_schedule_repository.dart';
import 'package:routine/features/routine/data/routine_repository.dart';
import 'package:routine/features/routine/domain/action.dart';
import 'package:routine/features/routine/domain/field.dart';
import 'package:routine/features/routine/presentation/list_display/schedule_display_widget.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FieldAdapter());
  Hive.registerAdapter(FieldTypeAdapter());
  Hive.registerAdapter(ActionAdapter());
  runApp(
    ProviderScope(
      overrides: [
        hiveRoutineRepositoryProvider.overrideWithValue(HiveRoutineRepository(
            box: await Hive.openBox(routineRepositoryKey))),
        hiveScheduleRepositoryProvider.overrideWithValue(HiveScheduleRepository(
            box: await Hive.openBox(scheduleRepositoryKey)))
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Routine',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white, brightness: Brightness.dark),
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Routine'),
      ),
      body: const ScheduleDisplayWidget(),
      floatingActionButton: FloatingActionButton.small(
        child: const Icon(Icons.add),
        onPressed: () {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Add Routine')));
        },
      ),
    );
  }
}
