import 'package:tiendien_alias/constants/app_images.dart';
import 'package:tiendien_alias/constants/color_constants.dart';
import 'package:tiendien_alias/constants/font_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class SocialSignUps extends StatelessWidget {
  const SocialSignUps({Key? key}) : super(key: key);

  //function for creating three social media login options
  //invoked in build
  Widget getSocialSignUpLink(String title, String icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 10.w, child: SvgPicture.asset(icon)),
        Text(
          'Continue with $title',
          style: const TextStyle(
            fontFamily: FontConstants.comfortaaBold,
            color: ColorConstants.accentColor,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 18.w,
        bottom: 4.h,
      ),
      child: SizedBox(
        height: 15.h,
        //width: 50.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getSocialSignUpLink('Google', AppImages.googleIcon),
            getSocialSignUpLink('Facebook', AppImages.facebookIcon),
            getSocialSignUpLink('Apple', AppImages.appleIcon),
          ],
        ),
      ),
    );
  }
}
