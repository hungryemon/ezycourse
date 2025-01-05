import 'package:ezycourse/app/helpers/constants/color_constants.dart';
import 'package:flutter/material.dart';

import 'custom_button.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.text,
    this.icon,
    this.isLeadingIcon = true,
    this.onPressed,
    this.backgroundColor = ColorConstants.buttonBgColorPrimary,
    this.textColor = ColorConstants.deepGreen80,
    this.borderColor = ColorConstants.transparent,
    this.hoverBgColor = ColorConstants.indigo80,
    this.size = ButtonSize.medium,
    this.borderRadius = 8.0,
    this.elevation = 0.0,
    this.isLoading = false,
    this.hoverTextColor = ColorConstants.white,
  }) : assert(text != null || icon != null,
            'Either text or icon must be provided.');

  final String? text;
  final IconData? icon;
  final bool isLeadingIcon;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final ButtonSize size;
  final double borderRadius;
  final double elevation;
  final bool isLoading;
  final Color hoverBgColor;
  final Color hoverTextColor;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: text,
      icon: icon,
        onPressed: onPressed,
        backgroundColor: backgroundColor,
        textColor: textColor,
        borderColor: borderColor,
        hoverBgColor: hoverBgColor,
        size: size,
        borderRadius: borderRadius,
        elevation: elevation,
        isLeadingIcon: isLeadingIcon,
        isLoading: isLoading,
        hoverTextColor: hoverTextColor);
  }
}
