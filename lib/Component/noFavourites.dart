import 'package:flutter/material.dart';

class NoFavourites extends StatelessWidget {
  const NoFavourites({
    Key key,
    @required this.isDark,
  }) : super(key: key);

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Icons.heart_broken,
          size: 600,
          color:
              isDark ? Colors.white.withAlpha(10) : Colors.black.withAlpha(10),
        ),
        Center(
            child: Text(
          "No Favourites? :(",
        ))
      ],
    );
  }
}
