import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constant/app_images.dart';
import '../../../../constant/theme/theme_extension.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 8,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _navBarIcons(context,AppIcons.share),
            _navBarIcons(context,AppIcons.share),
            _navBarIcons(context,AppIcons.share),
            _navBarIcons(context,AppIcons.share),
            _navBarIcons(context,AppIcons.share)
          ],
        ),
      ),
    );
  }
}

Widget _navBarIcons(BuildContext context, String icon){
  return SvgPicture.asset(
    icon,
    colorFilter: ColorFilter.mode(context.appColors.iconColor, BlendMode.srcIn),
    );
}