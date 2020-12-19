import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/models/user_model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'user_card.dart';

class MoreOptionsList extends StatelessWidget {
  final User currentUser;
  final List<List> _moreOptionsList = [
    [MdiIcons.shieldAccount, Colors.deepPurple, 'COVID-19 Info Center'],
    [MdiIcons.accountMultiple, Colors.cyan, 'Friends'],
    [MdiIcons.facebookMessenger, Palette.facebookBlue, 'Messanger'],
    [MdiIcons.flag, Colors.orange, 'Pages'],
    [MdiIcons.storefront, Palette.facebookBlue, 'MarketPlace'],
    [Icons.ondemand_video, Palette.facebookBlue, 'Watch'],
    [MdiIcons.calendarStar, Colors.red, 'Events'],
  ];

  MoreOptionsList({Key key, this.currentUser}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 280),
      child: ListView.builder(
        itemCount: 1 + _moreOptionsList.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0)
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: UserCard(user: currentUser),
            );
          final option = _moreOptionsList[index - 1];
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Option(option: option),
          );
        },
      ),
    );
  }
}

class Option extends StatelessWidget {
  final List option;

  const Option({Key key, this.option}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: Icon(
        option[0],
        color: option[1],
      ),
      title: Text(
        option[2],
      ),
    );
  }
}
