import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskify/core/utils/app_routes.dart';
import 'package:taskify/core/widgets/page_not_found.dart';
import 'package:taskify/features/auth/presentation/views/forgot_password_view.dart';
import 'package:taskify/features/auth/presentation/views/reset_password_view.dart';
import 'package:taskify/features/auth/presentation/views/signin_view.dart';
import 'package:taskify/features/auth/presentation/views/signup_view.dart';
import 'package:taskify/features/home/domain/entities/edit_user_entity.dart';
import 'package:taskify/features/home/domain/entities/task_entity.dart';
import 'package:taskify/features/home/presentation/views/add_task_view.dart';
import 'package:taskify/features/home/presentation/views/app_lock_type_view.dart';
import 'package:taskify/features/home/presentation/views/calender_view.dart';
import 'package:taskify/features/home/presentation/views/connected_accounts_view.dart';
import 'package:taskify/features/home/presentation/views/edit_task_view.dart';
import 'package:taskify/features/home/presentation/views/edit_user_view.dart';
import 'package:taskify/features/home/presentation/views/home_view.dart';
import 'package:taskify/features/home/presentation/views/main_view.dart';
import 'package:taskify/features/home/presentation/views/notifications_view.dart';
import 'package:taskify/features/home/presentation/views/pin_lock_type_view.dart';
import 'package:taskify/features/home/presentation/views/profile_view.dart';
import 'package:taskify/features/home/presentation/views/settings_view.dart';
import 'package:taskify/features/home/presentation/views/statistics_view.dart';
import 'package:taskify/features/home/presentation/views/task_details_view.dart';
import 'package:taskify/features/home/presentation/views/task_reminder_view.dart';
import 'package:taskify/features/home/presentation/views/task_repeat_view.dart';
import 'package:taskify/features/home/presentation/views/trash_view.dart';
import 'package:taskify/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:taskify/features/initial/presentation/views/initial_view.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.initial:
      return MaterialPageRoute(builder: (_) => const InitialView());

    case AppRoutes.onBoarding:
      return MaterialPageRoute(builder: (_) => const OnboardingView());

    case AppRoutes.signIn:
      return MaterialPageRoute(builder: (_) => const SigninView());

    case AppRoutes.signUp:
      return MaterialPageRoute(builder: (_) => const SignupView());

    case AppRoutes.forgotPassword:
      return MaterialPageRoute(builder: (_) => const ForgotPasswordView());

    case AppRoutes.resetPassword:
      return MaterialPageRoute(builder: (_) => const ResetPasswordView());

    case AppRoutes.main:
      return MaterialPageRoute(builder: (_) => const MainView());

    case AppRoutes.home:
      return MaterialPageRoute(builder: (_) => const HomeView());

    case AppRoutes.profile:
      return MaterialPageRoute(builder: (_) => const ProfileView());

    case AppRoutes.editUser:
      final editUserEntity = settings.arguments as EditUserEntity;
      return MaterialPageRoute(
        builder: (_) => Provider.value(
          value: editUserEntity,
          child: EditUserView(),
        ),
      );

    case AppRoutes.notifications:
      return MaterialPageRoute(builder: (_) => const NotificationsView());

    case AppRoutes.trash:
      return MaterialPageRoute(builder: (_) => const TrashView());

    case AppRoutes.calender:
      return MaterialPageRoute(builder: (_) => const CalenderView());

    case AppRoutes.taskDetails:
      final taskEntity = settings.arguments as TaskEntity;
      return MaterialPageRoute(
        builder: (_) =>
            Provider.value(value: taskEntity, child: TaskDetailsView()),
      );

    case AppRoutes.editTask:
      final taskEntity = settings.arguments as TaskEntity;
      return MaterialPageRoute(
        builder: (_) => Provider.value(
          value: taskEntity,
          child: EditTaskView(),
        ),
      );

    case AppRoutes.addTask:
      return MaterialPageRoute(builder: (_) => const AddTaskView());

    case AppRoutes.taskReminder:
      return MaterialPageRoute(builder: (_) => const TaskReminderView());

    case AppRoutes.taskRepeat:
      return MaterialPageRoute(builder: (_) => const TaskRepeatView());

    case AppRoutes.statistics:
      return MaterialPageRoute(builder: (_) => const StatisticsView());

    case AppRoutes.settings:
      return MaterialPageRoute(builder: (_) => const SettingsView());

    case AppRoutes.connectedAccounts:
      return MaterialPageRoute(builder: (_) => const ConnectedAccountsView());

    case AppRoutes.appLockType:
      return MaterialPageRoute(builder: (_) => const AppLockTypeView());

    case AppRoutes.pinLockType:
      return MaterialPageRoute(builder: (_) => const PinLockTypeView());

    case AppRoutes.passwordLockType:
      return MaterialPageRoute(builder: (_) => const AppLockTypeView());

    default:
      return MaterialPageRoute(
        builder: (_) => const PageNotFound(),
      );
  }
}
