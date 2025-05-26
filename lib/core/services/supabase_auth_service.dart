import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/errors/exceptions.dart';

class SupabaseAuthService {
  final SupabaseClient _supabase;

  SupabaseAuthService(this._supabase);

  Future<User> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
    String? imagePath,
  }) async {
    try {
      final AuthResponse res = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'image_path': imagePath,
        },
        emailRedirectTo: 'taskify://signup',
      );

      return res.user!;
    } on AuthException catch (e) {
      log('AuthException in signUpWithEmailAndPassword: ${e.message}');
      throw CustomException(e.message);
    } catch (e) {
      log('Exception in SupabaseAuthService.signUpWithEmailAndPassword: ${e.toString()}');
      throw CustomException('Something went wrong.');
    }
  }

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse res = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      return res.user!;
    } on AuthException catch (e) {
      log('AuthException in signUpWithEmailAndPassword: ${e.message}');
      throw CustomException(e.message);
    } catch (e) {
      log('Exception in SupabaseAuthService.signInWithEmailAndPassword: ${e.toString()}');
      throw CustomException('Something went wrong.');
    }
  }

  Future<void> signInWithIdToken({
    required String idToken,
    required String? accessToken,
  }) async {
    try {
      await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
    } catch (e) {
      log('Exception in SupabaseAuthService.signInWithIdToken: ${e.toString()}');
      throw CustomException('Something went wrong.');
    }
  }

  Future<void> signInWithOAuth({required OAuthProvider provider}) async {
    try {
      await _supabase.auth.signInWithOAuth(
        provider,
      );
    } catch (e) {
      log('Exception in SupabaseAuthService.signInWithOAuth: ${e.toString()}');
      throw CustomException('Something went wrong.');
    }
  }

  Future<void> updateUserData({
    String? newEmail,
    String? newPassword,
    String? newName,
    String? newImagePath,
    String? redirectTo,
  }) async {
    try {
      final updateData = <String, dynamic>{};

      if (newName != null) {
        updateData['full_name'] = newName;
      }
      if (newImagePath != null) {
        updateData['image_path'] = newImagePath;
      }

      if (newEmail != null) {
        updateData['email'] = newEmail;
      }

      await _supabase.auth.updateUser(
        UserAttributes(
          email: newEmail,
          password: newPassword,
          data: updateData,
        ),
        emailRedirectTo: redirectTo,
      );
    } catch (e) {
      log('Exception in SupabaseAuthService.updateUserData: ${e.toString()}');
      throw CustomException('Something went wrong.');
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await _supabase.auth.resetPasswordForEmail(
        email,
        redirectTo: 'taskify://reset-password',
      );
    } catch (e) {
      log('Exception in SupabaseAuthService.resetPassword: ${e.toString()}');
      throw CustomException('Something went wrong.');
    }
  }

  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      log('Exception in SupabaseAuthService.signOut: ${e.toString()}');
    }
  }

  Future<List<UserIdentity>> getUserIdentities() async {
    try {
      return await _supabase.auth.getUserIdentities();
    } catch (e) {
      log('Exception in SupabaseAuthService.getUserIdentities: ${e.toString()}');
      throw CustomException('Something went wrong.');
    }
  }

  Future<void> linkIdentity({required OAuthProvider provider}) async {
    try {
      await _supabase.auth.linkIdentity(
        provider,
        redirectTo: 'taskify://link-identity',
      );
    } catch (e) {
      log('Exception in SupabaseAuthService.linkIdentity: ${e.toString()}');
      throw CustomException('Something went wrong.');
    }
  }

  Future<void> unlinkIdentity() async {
    try {
      final identities = await _supabase.auth.getUserIdentities();
      final googleIdentity = identities.firstWhere(
        (element) => element.provider == 'google',
      );
      await _supabase.auth.unlinkIdentity(googleIdentity);
    } catch (e) {
      log('Exception in SupabaseAuthService.unlinkIdentity: ${e.toString()}');
      throw CustomException('Something went wrong.');
    }
  }
}
