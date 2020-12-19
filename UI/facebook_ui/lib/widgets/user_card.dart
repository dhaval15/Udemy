import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/models/user_model.dart';

import 'profile_avatar.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ProfileAvatar(
          url: user.imageUrl,
        ),
        SizedBox(width: 12),
        Text(
          user.name,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
