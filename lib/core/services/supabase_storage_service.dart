import 'dart:io';
import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/services/get_it_service.dart';

class SupabaseStorageService {
  final supabase = getIt<SupabaseClient>();

  Future<void> addData({
    required String table,
    required Map<String, dynamic> data,
    required dynamic dataId,
    required String column,
  }) async {
    await supabase.from(table).upsert({
      column: dataId,
      ...data,
    });
  }

  Future<Map<String, dynamic>> getSingleData({
    required String table,
    required String dataId,
    required String column,
  }) async {
    var data = await supabase.from(table).select().eq(column, dataId).single();
    return data;
  }

  Future<List<Map<String, dynamic>>> getAllData({
    required String table,
    required dynamic dataId,
    required String column,
  }) async {
    var data = await supabase.from(table).select().eq(column, dataId);
    return data;
  }

  Future<void> updateData({
    required String table,
    required Map<String, dynamic> data,
    required dynamic dataId,
    required String column,
  }) async {
    await supabase.from(table).update(data).eq(column, dataId);
  }

  Future<void> deleteSingleDataFromTable({
    required String table,
    required String dataId,
    required String column,
  }) async {
    await supabase.from(table).delete().eq(column, dataId);
  }

  Future<void> deleteMultipleDataFromTable({
    required String table,
    required List<String> dataIds,
    required String column,
  }) async {
    await supabase.from(table).delete().inFilter(column, dataIds);
  }

  Future<void> deleteDataFromStorage(
      {required String bucket, required List<String> dataPaths}) async {
    await supabase.storage.from(bucket).remove(dataPaths);
  }

  Future<void> moveDataFromStorage(
      {required String bucket,
      required String oldPath,
      required String newPath}) async {
    await supabase.storage.from(bucket).move(oldPath, newPath);
  }

  Future<String> uploadFile({
    required String bucket,
    required String path,
    required File file,
  }) async {
    final String fullPath = await supabase.storage.from(bucket).upload(
          path,
          file,
          fileOptions: FileOptions(upsert: true),
        );
    return fullPath;
  }

  Future<Uint8List> downloadFile(
      {required String path, required String bucket}) async {
    final Uint8List file = await supabase.storage.from(bucket).download(path);
    return file;
  }

  Future<String> getFileUrl({
    required String bucket,
    required String path,
  }) async {
    final String publicUrl = supabase.storage.from(bucket).getPublicUrl(path);

    return publicUrl;
  }
}
