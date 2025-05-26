import 'package:crypto/crypto.dart';
import 'dart:convert';

class CryptoService {
  static String hashPassword(String password, String salt) {
    final bytes = utf8.encode(password + salt);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static bool verifyPassword(String input, String storedHash, String salt) {
    final inputHash = hashPassword(input, salt);
    return inputHash == storedHash;
  }
}
