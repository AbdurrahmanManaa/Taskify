import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/features/auth/domain/entities/user_entity.dart';
import 'package:taskify/features/auth/domain/repos/auth_repo.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this._authRepo) : super(UserInitial());
  final AuthRepo _authRepo;

  UserEntity get userEntity => _authRepo.userEntity;
  List<UserIdentity> get userIdentities => _authRepo.userIdentities;

  Future<void> signUpWithEmailAndPassword({
    required String fullName,
    required String email,
    required String password,
    String? imagePath,
  }) async {
    emit(
      UserLoading(),
    );
    var result = await _authRepo.signUpWithEmailAndPassword(
      fullName: fullName,
      email: email,
      password: password,
      imagePath: imagePath,
    );
    result.fold(
      (failure) => emit(
        UserFailure(message: failure.message),
      ),
      (user) => emit(
        UserCreated(),
      ),
    );
  }

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    emit(
      UserLoading(),
    );
    var result = await _authRepo.signInWithEmailAndPassword(
        email: email, password: password);
    result.fold(
      (failure) => emit(
        UserFailure(message: failure.message),
      ),
      (user) => emit(
        UserLoggedIn(),
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    emit(
      UserLoading(),
    );
    try {
      await _authRepo.signInWithGoogle();
      emit(
        UserLoggedIn(),
      );
    } catch (e) {
      emit(
        UserFailure(message: "Failed to sign in with Google: $e"),
      );
    }
  }

  Future<UserEntity> getUserData({required String userId}) async {
    emit(
      UserLoading(),
    );
    try {
      var userEntity = await _authRepo.getUserData(uid: userId);
      emit(
        UserLoaded(),
      );
      return userEntity;
    } catch (e) {
      emit(
        UserFailure(message: "Failed to load user data: $e"),
      );
      return UserEntity(
        id: '',
        fullName: '',
        email: '',
      );
    }
  }

  Future<String> uploadUserImage({
    required File imageFile,
    required String userId,
  }) async {
    emit(
      UserLoading(),
    );
    try {
      var imagePath = await _authRepo.uploadUserImage(
        imageFile: imageFile,
        userId: userId,
      );
      emit(
        UserUpdated(),
      );
      return imagePath;
    } catch (e) {
      emit(
        UserFailure(message: "Failed to upload user image: $e"),
      );
      return '';
    }
  }

  Future<void> updateUserData({
    required String uid,
    String? newEmail,
    String? newPassword,
    String? newName,
    String? newImagePath,
    String? redirectTo,
  }) async {
    emit(
      UserLoading(),
    );
    try {
      await _authRepo.updateUserData(
        uid: uid,
        newEmail: newEmail,
        newPassword: newPassword,
        newName: newName,
        newImagePath: newImagePath,
        redirectTo: redirectTo,
      );
      emit(
        UserUpdated(),
      );
    } catch (e) {
      emit(
        UserFailure(message: "Failed to update user data: $e"),
      );
    }
  }

  Future<void> deleteImageFromStorage({required List<String> dataPaths}) async {
    emit(
      UserLoading(),
    );
    try {
      await _authRepo.deleteUserImageFromStorage(dataPaths: dataPaths);
      emit(
        UserUpdated(),
      );
    } catch (e) {
      emit(
        UserFailure(message: "Failed to delete user image: $e"),
      );
    }
  }

  Future<void> resetPassword({required String email}) async {
    await _authRepo.resetPassword(email: email);
  }

  Future<void> signOut() async {
    try {
      await _authRepo.signOut();
      emit(
        UserLoggedOut(),
      );
    } catch (e) {
      emit(UserFailure(message: "Failed to sign out: $e"));
    }
  }

  Future<List<UserIdentity>> getUserIdentities() async {
    emit(
      UserLoading(),
    );
    try {
      var userIdentities = await _authRepo.getUserIdentities();
      emit(
        UserLoaded(),
      );
      return userIdentities;
    } catch (e) {
      emit(
        UserFailure(message: "Failed to get user identities: $e"),
      );
      return [];
    }
  }

  Future<void> linkIdentity() async {
    emit(
      UserLoading(),
    );
    try {
      await _authRepo.linkIdentity();
      emit(
        UserIdentityLinked(),
      );
    } catch (e) {
      emit(
        UserFailure(message: "Failed to link identity: $e"),
      );
    }
  }

  Future<void> unlinkIdentity() async {
    emit(
      UserLoading(),
    );
    try {
      await _authRepo.unlinkIdentity();
      emit(
        UserIdentityUnlinked(),
      );
    } catch (e) {
      emit(
        UserFailure(message: "Failed to unlink identity: $e"),
      );
    }
  }
}
