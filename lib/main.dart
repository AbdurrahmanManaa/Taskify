import 'dart:async';
import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:taskify/core/services/hive_service.dart';
import 'package:taskify/core/utils/app_routes.dart';
import 'package:taskify/core/utils/app_constants.dart';
import 'package:taskify/core/functions/on_generate_route.dart';
import 'package:taskify/core/services/get_it_service.dart';
import 'package:taskify/core/utils/app_theme.dart';
import 'package:taskify/core/utils/custom_bloc_observer.dart';
import 'package:taskify/features/auth/domain/entities/user_entity.dart';
import 'package:taskify/features/auth/presentation/manager/cubits/user_cubit/user_cubit.dart';
import 'package:taskify/features/home/domain/entities/attachment_entity.dart';
import 'package:taskify/features/home/domain/entities/category_entity.dart';
import 'package:taskify/features/home/domain/entities/sub_task_entity.dart';
import 'package:taskify/features/home/domain/entities/task_entity.dart';
import 'package:taskify/features/home/domain/entities/task_reminder_entity.dart';
import 'package:taskify/features/home/domain/entities/task_repeat_entity.dart';
import 'package:taskify/features/home/domain/entities/user_preferences_entity.dart';
import 'package:taskify/features/home/presentation/manager/cubits/attachments_cubit/attachment_cubit.dart';
import 'package:taskify/features/home/presentation/manager/cubits/sub_task_cubit/sub_task_cubit.dart';
import 'package:taskify/features/home/presentation/manager/cubits/task_cubit/task_cubit.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: '.env');
  await Hive.initFlutter();
  Hive.registerAdapter(
    UserEntityAdapter(),
  );
  Hive.registerAdapter(
    TaskEntityAdapter(),
  );
  Hive.registerAdapter(
    TaskPriorityAdapter(),
  );
  Hive.registerAdapter(
    TaskStatusAdapter(),
  );
  Hive.registerAdapter(
    CategoryEntityAdapter(),
  );
  Hive.registerAdapter(
    TaskReminderEntityAdapter(),
  );
  Hive.registerAdapter(
    TaskRepeatEntityAdapter(),
  );
  Hive.registerAdapter(
    SubtaskEntityAdapter(),
  );
  Hive.registerAdapter(
    SubtaskStatusAdapter(),
  );
  Hive.registerAdapter(
    AttachmentEntityAdapter(),
  );
  Hive.registerAdapter(
    AttachmentStatusAdapter(),
  );

  Hive.registerAdapter(
    UserPreferencesEntityAdapter(),
  );
  Hive.registerAdapter(
    AppLanguageAdapter(),
  );
  Hive.registerAdapter(
    AppIconBadgeStyleAdapter(),
  );
  Hive.registerAdapter(
    AppLockTypeAdapter(),
  );

  await Hive.openBox(AppConstants.userBox);
  await Hive.openBox(AppConstants.taskBox);
  await Hive.openBox(AppConstants.subtaskBox);
  await Hive.openBox(AppConstants.attachmentsBox);
  await Hive.openBox(AppConstants.categoriesBox);
  await Hive.openBox(AppConstants.userPreferencesBox);
  await Hive.openBox(AppConstants.fileCacheBox);
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_API_Key']!,
  );
  initGetIt();
  Bloc.observer = CustomBlocObserver();
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<AuthState> authSubscription;
  final _appLinks = AppLinks();
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _handleAuthChanges();
    _initDeepLinks();
  }

  @override
  void dispose() {
    authSubscription.cancel();
    super.dispose();
  }

  void _handleAuthChanges() {
    final supabase = getIt<SupabaseClient>();
    authSubscription = supabase.auth.onAuthStateChange.listen(
      (data) {
        final AuthChangeEvent event = data.event;
        final Session? session = data.session;

        log('event: $event, session: $session');

        switch (event) {
          case AuthChangeEvent.signedIn:
            navigatorKey.currentState?.pushNamedAndRemoveUntil(
              AppRoutes.main,
              (route) => false,
            );
            break;
          case AuthChangeEvent.signedOut:
            navigatorKey.currentState?.pushNamedAndRemoveUntil(
              AppRoutes.signIn,
              (route) => false,
            );
            break;
          case AuthChangeEvent.passwordRecovery:
            navigatorKey.currentState?.pushNamed(AppRoutes.resetPassword);
            break;
          case AuthChangeEvent.mfaChallengeVerified:
            break;
          default:
            break;
        }
      },
    );
  }

  void _initDeepLinks() async {
    final initialUri = await _appLinks.getInitialLink();
    if (initialUri != null) {
      _handleDeepLink(initialUri);
    }

    _appLinks.uriLinkStream.listen((uri) {
      _handleDeepLink(uri);
    });
  }

  void _handleDeepLink(Uri uri) {
    if (uri.host == 'change-email') {
      navigatorKey.currentState?.popUntil((route) => false);

      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        AppRoutes.main,
        (route) => false,
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        navigatorKey.currentState?.pushReplacementNamed(AppRoutes.profile);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
          create: (_) => getIt<UserCubit>(),
        ),
        BlocProvider<TaskCubit>(
          create: (_) => getIt<TaskCubit>(),
        ),
        BlocProvider<SubtaskCubit>(
          create: (_) => getIt<SubtaskCubit>(),
        ),
        BlocProvider<AttachmentCubit>(
          create: (_) => getIt<AttachmentCubit>(),
        ),
      ],
      child: ValueListenableBuilder(
        valueListenable: HiveService.preferencesNotifier,
        builder: (context, value, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            onGenerateRoute: onGenerateRoute,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: value.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            initialRoute: AppRoutes.initial,
          );
        },
      ),
    );
  }
}
