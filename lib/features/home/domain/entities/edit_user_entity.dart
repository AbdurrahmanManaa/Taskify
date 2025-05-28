import 'package:taskify/features/auth/domain/entities/user_entity.dart';
import 'package:taskify/features/home/presentation/widgets/edit_user_view_body.dart';

class EditUserEntity {
  final UserEntity userEntity;
  final EditProfileType mode;

  EditUserEntity({
    required this.userEntity,
    required this.mode,
  });
}
