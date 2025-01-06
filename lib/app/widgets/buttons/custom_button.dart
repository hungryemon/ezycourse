import 'package:ezycourse/app/helpers/constants/color_constants.dart';
import 'package:flutter/material.dart';

enum ButtonSize {
  small,
  medium,
  large,
}

class CustomButton extends StatefulWidget {
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
  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    this.text,
    this.icon,
    this.isLeadingIcon = true,
    this.onPressed,
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
    required this.hoverBgColor,
    required this.size,
    this.borderRadius = 8.0,
    this.elevation = 0.0,
    this.isLoading = false,
    this.textStyle,
    required this.hoverTextColor,
  }) : assert(text != null || icon != null,
            'Either text or icon must be provided.');

  static const Map<ButtonSize, double> _buttonHeights = {
    ButtonSize.small: 40,
    ButtonSize.medium: 50,
    ButtonSize.large: 60,
  };

  static const Map<ButtonSize, EdgeInsets> _buttonPadding = {
    ButtonSize.small: EdgeInsets.symmetric(horizontal: 16),
    ButtonSize.medium: EdgeInsets.symmetric(horizontal: 20),
    ButtonSize.large: EdgeInsets.symmetric(horizontal: 22),
  };

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: CustomButton._buttonHeights[widget.size],
      decoration: BoxDecoration(
        color: isHovered ? widget.hoverBgColor : widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(color: widget.borderColor),
      ),
      child: Material(
        color: ColorConstants.transparent,
        child: InkWell(
            onTap: widget.isLoading ? null : widget.onPressed,
            radius: widget.borderRadius,
            splashColor: ColorConstants.transparent,
            mouseCursor: SystemMouseCursors.click,
            onHover: (value) {
              setState(() {
                isHovered = value;
              });
            },
            child: Padding(
              padding: CustomButton._buttonPadding[widget.size] ??
                  EdgeInsets.symmetric(horizontal: 22),
              child: widget.isLoading
                  ? Center(
                    child: SizedBox(
                      height: _getFontSize(widget.size),
                      width: _getFontSize(widget.size),
                      child:  CircularProgressIndicator(
                        strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>( isHovered ? widget.hoverTextColor : widget.textColor,),
                        ),
                    ),
                  )
                  : _buildContent(),
            )),
      ),
    );
  }

  Widget _buildContent() {
    if (widget.icon != null && widget.text != null) {
      // Icon + Text
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.isLeadingIcon) ...[
            Icon(widget.icon,
                size: _getIconSize(widget.size),   color: isHovered ? widget.hoverTextColor : widget.textColor,),
            const SizedBox(width: 8),
          ],
          Text(
            widget.text!,
            style: widget.textStyle ??
                TextStyle(
                  color:  isHovered ? widget.hoverTextColor : widget.textColor,
                  fontSize: _getFontSize(widget.size),
                  fontWeight: FontWeight.w600,
                ),
          ),
          if (!widget.isLeadingIcon) ...[
            const SizedBox(width: 8),
            Icon(widget.icon,
                size: _getIconSize(widget.size),   color: isHovered ? widget.hoverTextColor : widget.textColor,),
          ],
        ],
      );
    } else if (widget.icon != null) {
      // Only Icon
      return Center(
        child: Icon(widget.icon,
            size: _getIconSize(widget.size),   color: isHovered ? widget.hoverTextColor : widget.textColor,),
      );
    } else {
      // Only Text
      return Center(
        child: Text(
          widget.text!,
          textAlign: TextAlign.center,
          style: widget.textStyle ??
              TextStyle(
                color: isHovered ? widget.hoverTextColor : widget.textColor,
                fontSize: _getFontSize(widget.size),
                fontWeight: FontWeight.w600,
              ),
        ),
      );
    }
  }

  double _getFontSize(ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return 14.0;
      case ButtonSize.medium:
        return 16.0;
      case ButtonSize.large:
        return 18.0;
      default:
        return 16.0;
    }
  }

  double _getIconSize(ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return 18.0;
      case ButtonSize.medium:
        return 20.0;
      case ButtonSize.large:
        return 24.0;
      default:
        return 20.0;
    }
  }
}
