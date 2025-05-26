import 'package:flutter/material.dart';
import 'package:taskify/core/utils/app_colors.dart';
import 'package:taskify/core/utils/app_text_styles.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({
    super.key,
    required this.title,
    required this.userData,
    this.onTap,
    this.showArrow = true,
  });
  final Function()? onTap;
  final String title;
  final String userData;
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Text(
            title,
            style: AppTextStyles.medium18,
          ),
          const Spacer(),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.5,
            ),
            child: Text(
              userData,
              style: AppTextStyles.regular16
                  .copyWith(color: AppColors.bodyTextColor),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(width: 10),
          Visibility(
            visible: showArrow,
            child: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
