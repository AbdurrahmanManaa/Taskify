import 'package:supabase_flutter/supabase_flutter.dart';

class UserIdentityEntity {
  final UserIdentity? userIdentity;
  final String providerIcon;

  UserIdentityEntity({
    required this.userIdentity,
    required this.providerIcon,
  });
}
