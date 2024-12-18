import 'package:bagani/data/models/plant/plant.dart';
import 'package:bagani/ui/auth/auth_view.dart';
import 'package:bagani/ui/core/ui/app_navbar.dart';
import 'package:bagani/ui/home/home_view.dart';
import 'package:bagani/ui/profile/profile_view.dart';
import 'package:bagani/ui/search/search_view.dart';
import 'package:bagani/ui/store/plant_detail_view.dart';
import 'package:bagani/ui/store/store_view.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/auth', // Set the initial route to '/auth'
  routes: [
    GoRoute(
      path: '/auth',
      builder: (context, state) => AuthView(),
    ),
    GoRoute(
      path: '/:userId',
      builder: (context, state) {
        final userId = int.parse(state.pathParameters['userId']!);
        return BottomNavBarPage(userId: userId);
      },
    ),
    GoRoute(
      path: '/profile/:userId',
      builder: (context, state) {
        final userId = int.parse(state.pathParameters['userId']!);
        return ProfileView(profileId: userId);
      },
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchView(),
    ),
    GoRoute(
      path: '/store/:userId',
      builder: (context, state) {
        final userId = int.parse(state.pathParameters['userId']!);
        return StoreView(userId: userId);
      },
    ),
    GoRoute(
      path: '/plant-details/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return PlantDetailsScreen(id: id); // Pass it to the details screen
      },
    ),
  ],
);
