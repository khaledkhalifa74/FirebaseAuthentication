import 'package:firebase_features/core/utils/colors.dart';
import 'package:firebase_features/core/utils/styles.dart';
import 'package:firebase_features/core/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback itemCallBack;
  final double? height;
  final double? width;
  final IconData? icon;
  final Widget? previousIcon;
  final Color? borderColor;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? iconColor;
  final bool? isLoading;
  final String? loadingText;
  final bool? isDisabled;
  final Color? disabledTextColor;
  final Color? disabledBorderColor;
  final Color? disabledButtonColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.itemCallBack,
    this.height,
    this.width,
    this.icon,
    this.borderColor,
    this.textColor,
    this.backgroundColor,
    this.iconColor,
    this.isLoading,
    this.loadingText,
    this.isDisabled,
    this.disabledTextColor,
    this.disabledBorderColor,
    this.disabledButtonColor, this.previousIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 56,
      child: Material(
        color: isDisabled != null && isDisabled == true
            ? disabledButtonColor ?? kDisablesButtonColor
            : backgroundColor ?? kButtonColor,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          onTap: isDisabled != null && isDisabled == true ? null : itemCallBack,
          borderRadius: BorderRadius.circular(12.0),
          splashFactory: InkRipple.splashFactory,
          child: Container(
            width: width,
            height: height ?? 56,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color: isDisabled != null && isDisabled == true
                      ? disabledBorderColor ?? Colors.transparent
                      : borderColor ?? kPrimaryColor),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: isLoading == true
                ? Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        loadingText ?? '',
                        style: Styles.textStyle16.copyWith(
                          color: kWhiteColor,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const CustomLoadingIndicator(
                        color: kWhiteColor,
                        height: 20,
                        width: 20,
                      )
                    ],
                  )
                : Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon != null
                          ? Row(
                              children: [
                                Icon(
                                  icon,
                                  color: iconColor ?? kPrimaryColor,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                              ],
                            )
                          : previousIcon != null
                          ? Row(
                        children: [
                          Text(
                            text,
                            style: Styles.textStyle16.copyWith(
                                  color: isDisabled != null &&
                                      isDisabled == true
                                      ? disabledTextColor ?? kWhiteColor
                                      : textColor ?? kWhiteColor,
                                ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.visible,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          previousIcon!,
                        ],
                      )
                          :
                      Flexible(
                        child: Text(
                          text,
                          style: Styles.textStyle16.copyWith(
                            color: isDisabled != null && isDisabled == true
                                ? disabledTextColor ?? kWhiteColor
                                : textColor ?? kWhiteColor,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
