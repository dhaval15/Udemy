import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/models/user_model.dart';

import 'widgets.dart';

class Room extends StatelessWidget {
  final List<User> onlineUsers;

  const Room({Key key, this.onlineUsers}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 1 + onlineUsers.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0)
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: CreateRoomButton(),
            );
          final user = onlineUsers[index - 1];
          return Container(
            padding: EdgeInsets.all(4),
            child: ProfileAvatar(
              url: user.imageUrl,
              isActive: true,
            ),
          );
        },
      ),
    );
  }
}

class CreateRoomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: Colors.white,
      borderSide: BorderSide(width: 3, color: Colors.blue),
      textColor: Palette.facebookBlue,
      child: Row(
        children: [
          // ShaderMask(
          //   shaderCallback: (rect) =>
          //       Palette.createRoomGradient.createShader(rect),
          //   child: Icon(
          //     Icons.video_call,
          //     size: 35,
          //     color: Colors.white,
          //   ),
          // ),
          Icon(
            Icons.video_call,
            size: 35,
            color: Colors.white,
          ),
          SizedBox(width: 8),
          Text('Create\nRoom'),
        ],
      ),
    );
  }
}
