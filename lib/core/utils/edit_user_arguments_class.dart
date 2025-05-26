import 'package:taskify/features/auth/domain/entities/user_entity.dart';
import 'package:taskify/features/home/presentation/widgets/edit_user_view_body.dart';

class EditUserArguments {
  final UserEntity userEntity;
  final EditProfileType mode;

  EditUserArguments({
    required this.userEntity,
    required this.mode,
  });
}
