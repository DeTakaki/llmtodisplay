import 'package:go_router/go_router.dart';
import 'package:llmtodisplay/constants/routes_strings.dart';
import 'package:llmtodisplay/features/dashboard/presentation/screens/main_screen.dart';

final router = GoRouter(
  initialLocation: RoutesStrings.home,
  routes: [
    GoRoute(
      path: RoutesStrings.home,
      builder: (context, state) => DashboardScreen(),
    ),
  ],
);
