import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteIconButton extends StatefulWidget {
  const FavoriteIconButton({Key? key}) : super(key: key);

  @override
  _FavoriteIconButtonState createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        splashRadius: 25,
        onPressed: () {
          setState(() {
            isFavorite = !isFavorite;
          });
        },
        icon: !isFavorite
            ? Icon(
                CupertinoIcons.heart,
                color: Colors.white,
              )
            : Icon(
                CupertinoIcons.heart_fill,
                color: Colors.pink,
              ));
  }
}
