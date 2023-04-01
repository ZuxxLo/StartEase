import 'dart:ui';

import 'package:flutter/material.dart';

import '../Themes/colors.dart';
 
 
class BackgroundImageBlurred extends StatelessWidget {
  const BackgroundImageBlurred({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Image.asset(
        "assets/images/v.png",
        fit: BoxFit.fitHeight,
      ),
    );
  }
}

class LogoTakharouji extends StatelessWidget {
  const LogoTakharouji({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/takharouji_logo.png",
      fit: BoxFit.cover,
      scale: 1.3,
    );
  }
}

class AtIcon extends StatelessWidget {
  const AtIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ImageIcon(
      AssetImage("assets/icons/at_symbol.png"),
    );
  }
}

class ListTileIcons extends StatelessWidget {
  final String iconName;
  const ListTileIcons({
    super.key,
    required this.iconName,
  });

  @override
  Widget build(BuildContext context) {
    return ImageIcon(
      color: purpleColor,
      AssetImage("assets/icons/$iconName.png"),
    );
  }
}

class EditPencilIcon extends StatelessWidget {
  const EditPencilIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ImageIcon(
      size: 40,
      color: whiteColor,
      AssetImage("assets/icons/edit_pencil.png"),
    );
  }
}

class SmallBodyText extends StatelessWidget {
  final String text;

  const SmallBodyText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      return Text(
        text,
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
        ),
      );
    } catch (e) {
      print(e);
      return Text("");
    }
  }
}
class TitleSmallText extends StatelessWidget {
  final String text;

  const TitleSmallText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold,
         fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
      ),
    );
  }
}
class TitleMediumText extends StatelessWidget {
  final String text;

  const TitleMediumText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: whiteColor,
        fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
      ),
    );
  }
}
