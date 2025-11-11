import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:se7ety/features/auth/models/doctor_model.dart';
import 'package:se7ety/features/auth/models/user_type_enum.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ety/features/auth/presentation/pages/doctor_registeration_screen.dart';
import 'package:se7ety/features/auth/presentation/pages/login_screen.dart';
import 'package:se7ety/features/auth/presentation/pages/register_screen.dart';
import 'package:se7ety/features/intro/onboarding/onboarding_screen.dart';
import 'package:se7ety/features/intro/splash/splash_screen.dart';
import 'package:se7ety/features/intro/welcome/welcome_screen.dart';
import 'package:se7ety/features/patient/booking/presentation/booking.dart';
import 'package:se7ety/features/patient/home/presentation/pages/home_search_screen.dart';
import 'package:se7ety/features/patient/home/presentation/pages/specialization_search_screen.dart';
import 'package:se7ety/features/patient/main/nav_bar_screen.dart';
import 'package:se7ety/features/patient/search/page/doctor_profile_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Routes {
  static const String splash = "/splash";
  static const String onboarding = "/onboarding";
  static const String welcome = "/welcome";
  static const String login = "/login";
  static const String register = "/register";
  static const String main = "/main";
  static const String doctorRegistration = "/doctorRegistration";
  static const String patientMain = "/patientMain";
  static const String specializationSearch = "/specializationSearch";
  static const String homeSearch = "/homeSearch";
  static const String doctorProfile = "/doctorProfile";
  static const String bookingForm = "/bookingForm";

  static GoRouter routes = GoRouter(
    initialLocation: splash,
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: LoginScreen(userType: state.extra as UserTypeEnum),
        ),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: RegisterScreen(userType: state.extra as UserTypeEnum),
        ),
      ),
      GoRoute(
        path: doctorRegistration,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: DoctorRegistrationScreen(),
        ),
      ),
      GoRoute(
        path: patientMain,
        builder: (context, state) => const PatientMainScreen(),
      ),
      GoRoute(
        path: specializationSearch,
        builder: (context, state) =>
            SpecializationSearchScreen(specialization: state.extra as String),
      ),
      GoRoute(
        path: homeSearch,
        builder: (context, state) =>
            HomeSearchScreen(searchKey: state.extra as String),
      ),
      GoRoute(
        path: doctorProfile,
        builder: (context, state) =>
            DoctorProfileScreen(doctorModel: state.extra as DoctorModel),
      ),
      GoRoute(
        path: bookingForm,
        builder: (context, state) =>
            BookingFormScreen(doctor: state.extra as DoctorModel),
      ),
    ],
  );
}
