import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/helpers/constants/asset_constants.dart';

class LoginTopSection extends StatelessWidget {
  const LoginTopSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
       SizedBox(height: 100.h,),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 48.w),
          child: Image.asset(AssetConstants.logo),
        ),
      ],
    );
  }
}