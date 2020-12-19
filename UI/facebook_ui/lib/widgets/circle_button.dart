import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final Function onPressed;

  const CircleButton({Key key, this.icon, this.size, this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          size: size,
          color: Colors.black,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
