import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:dev_community/utils/enums/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginBtn extends StatelessWidget {
  final LoginType loginType;
  final void Function() onPressed;

  const LoginBtn({super.key, required this.loginType, required this.onPressed});

  String _lableText() {
    String label;

    switch (loginType) {
      case LoginType.email:
        label = "이메일";
        break;
      case LoginType.kakao:
        label = "카카오";
        break;
      case LoginType.google:
        label = "구글";
        break;
      default:
        label = "";
        break;
    }

    return "$label로 로그인";
  }

  String _icon() {
    String icon;

    switch (loginType) {
      case LoginType.email:
        icon = "assets/svgs/logos/google.svg";
        break;
      case LoginType.kakao:
        icon = "assets/svgs/logos/kakao.svg";
        break;
      case LoginType.google:
        icon = "assets/svgs/logos/google.svg";
        break;
      default:
        icon = "assets/svgs/commons/question-mark.svg";
        break;
    }

    return icon;
  }

  Color? _backgroundColor() {
    Color? color;

    switch (loginType) {
      case LoginType.email:
        color = CustomColor.mint;
        break;
      case LoginType.kakao:
        color = CustomColor.kakao;
        break;
      case LoginType.google:
        color = CustomColor.google;
        break;
      default:
        break;
    }

    return color;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: _backgroundColor(),
          foregroundColor: Colors.black,
          side: const BorderSide(
            color: Colors.transparent,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              _icon(),
              width: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              _lableText(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
