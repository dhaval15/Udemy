import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: buildBox(),
      subtitle: buildBox(),
    );
  }

  Widget buildBox() => Container(
        color: Colors.grey[200],
        width: 180,
        height: 24,
      );
}
