import 'package:ezycourse/app/helpers/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showLogoutAlertDialog(BuildContext context,
    {required Function() onTapYes}) {
  showCupertinoDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 27.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Logout',
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: ColorConstants.black95,
                        ),
                  ),
                  SizedBox(height: 13.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Are you sure, you want to log out?',
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: ColorConstants.black80,
                              ),
                    ),
                  ),
                  SizedBox(height: 34.h),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: ColorConstants.dividerColor
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            onTapYes();
                          },
                          child:  SizedBox(
                            height: 60,
                            child: Center(
                              child: Text(
                                'Yes',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorConstants.indigo60)
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 60,
                        color: ColorConstants.dividerColor
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: SizedBox(
                            height: 60,
                            child: Center(
                              child: Text(
                                'No',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorConstants.grayDark)
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ));
}
