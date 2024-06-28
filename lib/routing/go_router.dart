import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:routine/features/routine/presentation/edit_routine/edit_routine_page.dart';
import 'package:routine/features/routine/presentation/list_display/schedule_list_page.dart';
import 'package:routine/routing/routes.dart';

import '../features/routine/presentation/edit_routine/edit_action_page.dart';

final goRouterProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    routes: [
      GoRoute(
        path: scheduleListPageRoute(),
        builder: (context, state) => const ScheduleListPage(),
      ),
      GoRoute(
        path: editRoutinePageRoute(':routineId'),
        builder: (context, state) =>
            EditRoutinePage(id: state.pathParameters['routineId']),
      ),
      GoRoute(
        path: editActionPageRoute(':actionId'),
        builder: (context, state) =>
            EditActionPage(id: state.pathParameters['actionId']),
      )
    ],
  ),
);
