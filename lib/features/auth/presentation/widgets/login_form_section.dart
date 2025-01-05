
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/helpers/constants/color_constants.dart';
import '../../../../app/widgets/buttons/custom_button.dart';
import '../../../../app/widgets/buttons/primary_button.dart';
import '../controllers/login_controller.dart';


class LoginFormSection extends StatefulWidget {
  const LoginFormSection({super.key, required this.controller});
  final LoginController controller;

  @override
  State<LoginFormSection> createState() => _LoginFormSectionState();
}

class _LoginFormSectionState extends State<LoginFormSection> {
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorConstants.deepGreen120,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.r),
            topRight: Radius.circular(40.r),
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(top: 4.h),
          decoration: BoxDecoration(
            color: ColorConstants.deepGreen100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.r),
              topRight: Radius.circular(40.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Sign In',
                  style: TextStyle(
                    color: ColorConstants.white,
                    fontSize: 38.sp,
                    fontFamily: 'Figtree',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 36.h,
                ),
                _buildForm(context)
              ],
            ),
          ),
        ));
  }

  Form _buildForm(BuildContext context) {
    OutlineInputBorder textFieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(9.22),
      borderSide: BorderSide(
          color: ColorConstants.teal60.withOpacity(0.2), width: 1.22),
    );

    TextStyle textFieldInputStyle = Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(color: ColorConstants.white80, fontSize: 19.5);
    return Form(
      key: widget.controller.userFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Email Field
          ...[
            Text(
              "Email",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 17.06, color: ColorConstants.white80),
            ),
            SizedBox(
              height: 7.31.h,
            ),
            TextFormField(
              controller: widget.controller.emailController,
              decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle:
                      TextStyle(color: ColorConstants.white.withOpacity(.5)),
                  filled: true,
                  fillColor: ColorConstants.white.withOpacity(.1),
                  focusedBorder: textFieldBorder,
                  enabledBorder: textFieldBorder,
                  border: textFieldBorder,
                  isDense: true),
              style: textFieldInputStyle,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!GetUtils.isEmail(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
          ],
          SizedBox(height: 21.41.h),
          // Password Field
          ...[
            Text(
              "Password",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 17.06, color: ColorConstants.white80),
            ),
            SizedBox(
              height: 7.31.h,
            ),
            TextFormField(
              controller: widget.controller.passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle:
                    TextStyle(color: ColorConstants.white.withOpacity(.5)),
                filled: true,
                fillColor: ColorConstants.white.withOpacity(.1),
                focusedBorder: textFieldBorder,
                enabledBorder: textFieldBorder,
                border: textFieldBorder,
                isDense: true,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: ColorConstants.white,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              style: textFieldInputStyle,
              obscureText: _obscurePassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
          ],
          SizedBox(height: 28.97.h),
          //Rmember Me
          Obx(() {
            widget.controller.isRememberMe.value;
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16,
                  width: 16,
                  child: Checkbox(
                    visualDensity: VisualDensity.compact,
                    value: widget.controller.isRememberMe.value,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r)),
                    side: BorderSide(width: .6, color: ColorConstants.white),
                    activeColor: ColorConstants.indigo100,
                    checkColor: ColorConstants.white,
                    onChanged: (value) {
                      widget.controller.isRememberMe(value);
                    },
                  ),
                ),
                SizedBox(width: 8.w),
                Text('Remember me',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: ColorConstants.white)),
              ],
            );
          }),

          SizedBox(height: 45.22.h),
          // Login Button
          Obx(() {
            widget.controller.isLoading.value;
            return PrimaryButton(
              isLoading: widget.controller.isLoading.value,
              onPressed: () {
                widget.controller.login(context);
              },
              text: 'Login',
              size: ButtonSize.large,
            );
          }),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
