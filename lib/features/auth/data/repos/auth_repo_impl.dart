import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/errors/exceptions.dart';
import 'package:taskify/core/errors/failures.dart';
import 'package:taskify/core/services/hive_service.dart';
import 'package:taskify/core/services/supabase_auth_service.dart';
import 'package:taskify/core/services/supabase_storage_service.dart';
import 'package:taskify/core/utils/endpoints.dart';
import 'package:taskify/features/auth/data/models/user_model.dart';
import 'package:taskify/features/auth/domain/entities/user_entity.dart';
import 'package:taskify/features/auth/domain/repos/auth_repo.dart';
import 'package:path/path.dart' as p;

class AuthRepoImpl extends AuthRepo {
  final SupabaseAuthService _supabaseAuth;
  final SupabaseStorageService _supabaseStorage;
  final HiveService _hiveService;

  AuthRepoImpl(this._supabaseAuth, this._supabaseStorage, this._hiveService);

  UserEntity? _userEntity;
  List<UserIdentity> _userIdentities = [];

  @override
  UserEntity get userEntity => _userEntity!;

  @override
  List<UserIdentity> get userIdentities => _userIdentities;

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword({
    required String fullName,
    required String email,
    required String password,
    String? imagePath,
  }) async {
    User? user;
    try {
      user = await _supabaseAuth.signUpWithEmailAndPassword(
        fullName: fullName,
        email: email,
        password: password,
        imagePath: imagePath,
      );
      _userEntity = UserEntity(
        fullName: fullName,
        email: email,
        imagePath: imagePath,
        id: user.id,
      );

      return right(_userEntity!);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log(
        'Exception in AuthRepoImpl.signUpWithEmailAndPassword: ${e.toString()}',
      );
      return left(
        ServerFailure(
          ('Something went wrong. Please try again later.'),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      var user = await _supabaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      _userEntity = await getUserData(uid: user.id);
      await saveUserData(userEntity: _userEntity!);
      return right(_userEntity!);
    } catch (e) {
      log('Exception in AuthRepoImpl.signInWithEmailAndPassword: ${e.toString()}');
      return left(
        ServerFailure('Something went wrong'),
      );
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: dotenv.env['IOS_CLIENT_ID'],
        serverClientId: dotenv.env['WEB_CLIENT_ID'],
      );
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }
      await _supabaseAuth.signInWithIdToken(
        idToken: idToken,
        accessToken: accessToken,
      );
    } catch (e) {
      log('Exception in AuthRepoImpl.signInWithGoogle: ${e.toString()}');
      throw CustomException('Something went wrong.');
    }
  }

  @override
  Future<String> uploadUserImage({
    required File imageFile,
    required String userId,
  }) async {
    try {
      String imageName = p.basenameWithoutExtension(imageFile.path);
      String imageExtension = p.extension(imageFile.path);
      String path = '$userId/$imageName$imageExtension';

      await _supabaseStorage.uploadFile(
        bucket: Endpoints.usersImagesBucket,
        path: path,
        file: imageFile,
      );

      return path;
    } catch (e) {
      log('Error uploading image: ${e.toString()}');
      throw CustomException('Failed to upload image.');
    }
  }

  @override
  Future<void> addUserData({required UserEntity userEntity}) async {
    await _supabaseStorage.addData(
      table: Endpoints.usersTable,
      data: UserModel.fromEntity(userEntity).toJson(),
      dataId: userEntity.id,
      column: 'id',
    );
  }

  @override
  Future<UserEntity> getUserData({required String uid}) async {
    if (uid.isEmpty) {
      throw CustomException('User ID is missing. Cannot fetch user data.');
    }
    var userData = await _supabaseStorage.getSingleData(
      table: Endpoints.usersTable,
      dataId: uid,
      column: 'id',
    );
    var userModel = UserModel.fromJson(userData);

    String? imageUrl;
    if (userModel.imagePath != null && userModel.imagePath!.isNotEmpty) {
      imageUrl = await _supabaseStorage.getFileUrl(
        bucket: Endpoints.usersImagesBucket,
        path: userModel.imagePath!,
      );
    } else {
      imageUrl = null;
    }
    var userEntity = userModel.toEntity(imageUrl: imageUrl);
    _userEntity = userEntity;
    return userEntity;
  }

  @override
  Future<void> saveUserData({required UserEntity userEntity}) async {
    await _hiveService.setUserData(userEntity);
  }

  @override
  Future<void> updateUserData({
    required String uid,
    String? newEmail,
    String? newPassword,
    String? newName,
    String? newImagePath,
    String? redirectTo,
  }) async {
    try {
      await _supabaseAuth.updateUserData(
        newEmail: newEmail,
        newPassword: newPassword,
        newName: newName,
        newImagePath: newImagePath,
        redirectTo: redirectTo,
      );
      await refreshUser(uid: uid);
    } catch (e) {
      log('Exception in AuthRepoImpl.updateUserData: ${e.toString()}');
      throw CustomException('Something went wrong.');
    }
  }

  @override
  Future<void> refreshUser({required String uid}) async {
    try {
      _userEntity = await getUserData(uid: uid);
    } catch (e) {
      log('Error refreshing user: $e');
      throw CustomException('Failed to refresh user.');
    }
  }

  @override
  Future<void> deleteUserImageFromStorage(
      {required List<String> dataPaths}) async {
    await _supabaseStorage.deleteDataFromStorage(
      bucket: Endpoints.usersImagesBucket,
      dataPaths: dataPaths,
    );
  }

  @override
  Future<void> resetPassword({required String email}) async {
    await _supabaseAuth.resetPassword(email: email);
  }

  @override
  Future<void> signOut() async {
    await _supabaseAuth.signOut();
  }

  @override
  Future<List<UserIdentity>> getUserIdentities() async {
    try {
      var identities = await _supabaseAuth.getUserIdentities();
      _userIdentities = identities;
      return identities;
    } catch (e) {
      log('Exception in AuthRepoImpl.getUserIdentities: ${e.toString()}');
      throw CustomException('Something went wrong.');
    }
  }

  @override
  Future<void> linkIdentity() async {
    try {
      await _supabaseAuth.linkIdentity(provider: OAuthProvider.google);
    } catch (e) {
      log('Exception in AuthRepoImpl.linkIdentity: ${e.toString()}');
      throw CustomException('Something went wrong.');
    }
  }

  @override
  Future<void> unlinkIdentity() async {
    try {
      await _supabaseAuth.unlinkIdentity();
    } catch (e) {
      log('Exception in AuthRepoImpl.unlinkIdentity: ${e.toString()}');
      throw CustomException('Something went wrong.');
    }
  }
}
