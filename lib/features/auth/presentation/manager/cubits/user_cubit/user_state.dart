part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserCreated extends UserState {}

final class UserLoggedIn extends UserState {}

final class UserLoaded extends UserState {}

final class UserIdentityLinked extends UserState {}

final class UserIdentityUnlinked extends UserState {}

final class UserUpdated extends UserState {}

final class UserLoggedOut extends UserState {}

final class UserDeleted extends UserState {}

final class UserFailure extends UserState {
  final String message;
  UserFailure({required this.message});
}
