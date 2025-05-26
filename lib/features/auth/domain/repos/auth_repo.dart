import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/errors/failures.dart';
import 'package:taskify/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword({
    required String fullName,
    required String email,
    required String password,
    String? imagePath,
  });
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<void> signInWithGoogle();
  Future<String> uploadUserImage(
      {required File imageFile, required String userId});
  void addUserData({required UserEntity userEntity});
  Future<UserEntity> getUserData({required String uid});
  Future<void> saveUserData({required UserEntity userEntity});
  Future<void> updateUserData({
    required String uid,
    String? newEmail,
    String? newPassword,
    String? newName,
    String? newImagePath,
    String? redirectTo,
  });
  Future<void> refreshUser({required String uid});
  Future<void> deleteUserImageFromStorage({required List<String> dataPaths});
  Future<void> resetPassword({required String email});
  Future<void> signOut();
  Future<List<UserIdentity>> getUserIdentities();
  Future<void> linkIdentity();
  Future<void> unlinkIdentity();

  UserEntity get userEntity;
  List<UserIdentity> get userIdentities;
}
