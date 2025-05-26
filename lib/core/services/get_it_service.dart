import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/services/hive_service.dart';
import 'package:taskify/core/services/supabase_auth_service.dart';
import 'package:taskify/core/services/supabase_storage_service.dart';
import 'package:taskify/features/auth/data/repos/auth_repo_impl.dart';
import 'package:taskify/features/auth/domain/repos/auth_repo.dart';
import 'package:taskify/features/auth/presentation/manager/cubits/user_cubit/user_cubit.dart';
import 'package:taskify/features/home/data/repos/home_repo_impl.dart';
import 'package:taskify/features/home/domain/repos/home_repo.dart';
import 'package:taskify/features/home/presentation/manager/cubits/attachments_cubit/attachment_cubit.dart';
import 'package:taskify/features/home/presentation/manager/cubits/sub_task_cubit/sub_task_cubit.dart';
import 'package:taskify/features/home/presentation/manager/cubits/task_cubit/task_cubit.dart';

final getIt = GetIt.instance;

void initGetIt() {
  getIt.registerSingleton<SupabaseClient>(Supabase.instance.client);

  getIt.registerSingleton<SupabaseAuthService>(
    SupabaseAuthService(
      getIt<SupabaseClient>(),
    ),
  );

  getIt.registerSingleton<SupabaseStorageService>(
    SupabaseStorageService(
      getIt<SupabaseClient>(),
    ),
  );

  getIt.registerSingleton<HiveService>(
    HiveService(),
  );

  getIt.registerSingleton<HomeRepo>(
    HomeRepoImpl(
      getIt<SupabaseStorageService>(),
      getIt<HiveService>(),
    ),
  );

  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      getIt<SupabaseAuthService>(),
      getIt<SupabaseStorageService>(),
      getIt<HiveService>(),
    ),
  );

  getIt.registerFactory<UserCubit>(
    () => UserCubit(
      getIt<AuthRepo>(),
    ),
  );

  getIt.registerFactory<TaskCubit>(
    () => TaskCubit(
      getIt<HomeRepo>(),
    ),
  );

  getIt.registerFactory<SubtaskCubit>(
    () => SubtaskCubit(
      getIt<HomeRepo>(),
    ),
  );

  getIt.registerFactory<AttachmentCubit>(
    () => AttachmentCubit(
      getIt<HomeRepo>(),
    ),
  );
}
