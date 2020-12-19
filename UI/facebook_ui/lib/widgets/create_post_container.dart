import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/models/user_model.dart';

import 'widgets.dart';

class CreatePostContainer extends StatelessWidget {
  final User currentUser;

  const CreatePostContainer({Key key, this.currentUser}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: Column(
        children: [
          Row(
            children: [
              ProfileAvatar(url: currentUser.imageUrl),
              SizedBox(height: 16),
              Expanded(
                child: TextField(
                  decoration: InputDecoration.collapsed(
                      hintText: 'What\'s on your mind ?'),
                ),
              ),
            ],
          ),
          Divider(
            height: 10,
            thickness: 5,
          ),
          Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton.icon(
                  icon: Icon(
                    Icons.videocam,
                    color: Colors.red,
                  ),
                  onPressed: () {},
                  label: Text('live'),
                ),
                VerticalDivider(width: 8),
                FlatButton.icon(
                  icon: Icon(
                    Icons.photo_library,
                    color: Colors.green,
                  ),
                  onPressed: () {},
                  label: Text('Photos'),
                ),
                VerticalDivider(width: 8),
                FlatButton.icon(
                  icon: Icon(
                    Icons.video_call,
                    color: Colors.purpleAccent,
                  ),
                  onPressed: () {},
                  label: Text('Room'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
