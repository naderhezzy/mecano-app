import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mecano_app/features/auth/presentation/providers/auth_providers.dart';
import 'package:mecano_app/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:mecano_app/features/auth/presentation/screens/login_screen.dart';
import 'package:mecano_app/features/auth/presentation/screens/register_screen.dart';
import 'package:mecano_app/features/bookings/presentation/screens/booking_confirmation_screen.dart';
import 'package:mecano_app/features/bookings/presentation/screens/booking_detail_screen.dart';
import 'package:mecano_app/features/bookings/presentation/screens/booking_flow_screen.dart';
import 'package:mecano_app/features/bookings/presentation/screens/booking_history_screen.dart';
import 'package:mecano_app/features/garages/presentation/screens/garage_detail_screen.dart';
import 'package:mecano_app/features/garages/presentation/screens/garages_list_screen.dart';
import 'package:mecano_app/features/home/presentation/screens/home_screen.dart';
import 'package:mecano_app/features/maintenance/presentation/screens/add_maintenance_screen.dart';
import 'package:mecano_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:mecano_app/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:mecano_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:mecano_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:mecano_app/features/vehicles/presentation/screens/add_vehicle_screen.dart';
import 'package:mecano_app/features/vehicles/presentation/screens/edit_vehicle_screen.dart';
import 'package:mecano_app/features/vehicles/presentation/screens/garage_screen.dart';
import 'package:mecano_app/features/vehicles/presentation/screens/vehicle_detail_screen.dart';
import 'package:mecano_app/routing/scaffold_with_nav_bar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter appRouter(Ref ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    redirect: (context, state) {
      final isLoggedIn = authState.valueOrNull != null;
      final isAuthRoute = state.matchedLocation.startsWith('/auth');
      final isSplash = state.matchedLocation == '/';
      final isOnboarding = state.matchedLocation == '/onboarding';

      if (isSplash || isOnboarding) return null;

      if (!isLoggedIn && !isAuthRoute) return '/auth/login';
      if (isLoggedIn && isAuthRoute) return '/home';

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/auth/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/auth/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/auth/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) =>
            ScaffoldWithNavBar(child: child),
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/garage',
            builder: (context, state) => const GarageScreen(),
            routes: [
              GoRoute(
                path: 'add',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const AddVehicleScreen(),
              ),
              GoRoute(
                path: ':vehicleId',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => VehicleDetailScreen(
                  vehicleId:
                      state.pathParameters['vehicleId']!,
                ),
                routes: [
                  GoRoute(
                    path: 'edit',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => EditVehicleScreen(
                      vehicleId:
                          state.pathParameters['vehicleId']!,
                    ),
                  ),
                  GoRoute(
                    path: 'maintenance/add',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) =>
                        AddMaintenanceScreen(
                      vehicleId:
                          state.pathParameters['vehicleId']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: '/services',
            builder: (context, state) => const GaragesListScreen(),
            routes: [
              GoRoute(
                path: ':garageId',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => GarageDetailScreen(
                  garageId: state.pathParameters['garageId']!,
                ),
                routes: [
                  GoRoute(
                    path: 'book',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => BookingFlowScreen(
                      garageId:
                          state.pathParameters['garageId']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: '/bookings',
            builder: (context, state) =>
                const BookingHistoryScreen(),
            routes: [
              GoRoute(
                path: ':bookingId',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => BookingDetailScreen(
                  bookingId:
                      state.pathParameters['bookingId']!,
                ),
                routes: [
                  GoRoute(
                    path: 'confirmation',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) =>
                        BookingConfirmationScreen(
                      bookingId:
                          state.pathParameters['bookingId']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
            routes: [
              GoRoute(
                path: 'edit',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) =>
                    const EditProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
