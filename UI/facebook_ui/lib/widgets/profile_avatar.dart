import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';

class ProfileAvatar extends StatelessWidget {
  final String url;
  final bool isActive;
  final bool hasBorder;

  const ProfileAvatar(
      {Key key, this.url, this.isActive = false, this.hasBorder = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: hasBorder ? 22 : 20,
          backgroundColor: Palette.facebookBlue,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[200],
            backgroundImage: NetworkImage(url),
          ),
        ),
        if (isActive)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: Palette.online,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          )
      ],
    );
  }
}
