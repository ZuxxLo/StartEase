 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
 
import '../Themes/colors.dart';
import '../backend/link_api.dart';
import '../main.dart';
import '../model/user_model.dart';

class LogoStartEase extends StatelessWidget {
  const LogoStartEase({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
        color: Theme.of(context).primaryColorLight,
        image: const Svg(
          "assets/images/start_ease_logo.svg",
        ));
  }
}

class LogoStartEaseWithText extends StatelessWidget {
  const LogoStartEaseWithText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const LogoStartEase(),
        Text(
          "StartEase",
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColorLight,
          ),
        ),
      ],
    );
  }
}

class BackIconButton extends StatelessWidget {
  const BackIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.back();
      },
      icon: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).primaryColorLight,
            ),
            borderRadius: BorderRadius.circular(50)),
        child: ImageIcon(
          color: Theme.of(context).primaryColorLight,
          const Svg("assets/icons/back_icon.svg"),
        ),
      ),
    );
  }
}

class MenuIcon extends StatelessWidget {
  const MenuIcon({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).primaryColorLight,
            ),
            borderRadius: BorderRadius.circular(50)),
        child: const ImageIcon(
          size: 20,
          Svg("assets/icons/menu_icon.svg"),
        ),
      ),
    );
  }
}

class EmailIcon extends StatelessWidget {
  const EmailIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ImageIcon(
      size: 25,
      Svg(
        "assets/icons/email_icon.svg",
      ),
    );
  }
}

class PasswordKeyIcon extends StatelessWidget {
  const PasswordKeyIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ImageIcon(
      Svg("assets/icons/password_key_icon.svg"),
    );
  }
}

class ProfileCircleIcon extends StatelessWidget {
  const ProfileCircleIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ImageIcon(
      size: 35,
      Svg("assets/icons/profile_circle_icon.svg"),
    );
  }
}

class SendIcon extends StatelessWidget {
  const SendIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ImageIcon(
      color: bluePurpleColor,
      Svg("assets/icons/send_icon.svg"),
    );
  }
}

class DeleteIcon extends StatelessWidget {
  const DeleteIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ImageIcon(
      color: bluePurpleColor,
      Svg("assets/icons/delete_icon.svg"),
    );
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //  await CachedNetworkImage.evictFromCache(url);4
    return SizedBox(
        height: 120,
        width: 120,
        child: !(userModel.photoUrl ==
                "https://via.placeholder.com/640x480.png/002277?text=architecto")
            ? ClipOval(
                child: MainFunctions.pickedImage == null
                    ? Image.network(
                        linkServerName + userModel.photoUrl!.substring(21),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const CircularProgressIndicator();
                        },
                      )
                    : Image.file(
                        MainFunctions.pickedImage!,
                        fit: BoxFit.cover,
                      ))
            : ClipOval(
                child: Container(
                  alignment: Alignment.center,
                  color: MainFunctions.generatePresizedColor(
                      userModel.username.length),
                  child: Text(
                    userModel.username[0].toUpperCase(),
                    // style: const TextStyle(
                    //     fontSize: 27, color: purpleTextColor),
                  ),
                ),
              ));
  }
}

class ProfilePictureForOtherUsers extends StatelessWidget {
  const ProfilePictureForOtherUsers({
    super.key,
    required this.userModel,
  });
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    //  await CachedNetworkImage.evictFromCache(url);4
    return SizedBox(
        height: 120,
        width: 120,
        child: !(userModel.photoUrl ==
                "https://via.placeholder.com/640x480.png/002277?text=architecto")
            ? ClipOval(
                child:  Image.network(
                        linkServerName + userModel.photoUrl!.substring(21),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const CircularProgressIndicator();
                        },
                      )
                  )
            : ClipOval(
                child: Container(
                  alignment: Alignment.center,
                  color: MainFunctions.generatePresizedColor(
                      userModel.username.length),
                  child: Text(
                    userModel.username[0].toUpperCase(),
                    // style: const TextStyle(
                    //     fontSize: 27, color: purpleTextColor),
                  ),
                ),
              ));
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
       return const Text("");
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

class UserNameText extends StatelessWidget {
  final String text;

  const UserNameText({
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
        color: Theme.of(context).primaryColorLight.withAlpha(200),
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
        fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
      ),
    );
  }
}

class TitleLargeText extends StatelessWidget {
  final String text;

  const TitleLargeText({
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
        fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
      ),
    );
  }
}
class ActiveBottomBarIcon extends StatelessWidget {
  const ActiveBottomBarIcon({
    super.key,
    required this.widgetIcon,
  });
  final Widget widgetIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 35,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: bluePurpleColor),
      child: widgetIcon,
    );
  }
}