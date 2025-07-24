import 'package:firebase_features/core/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key, this.width, this.height, this.color});
final double? width;
final double? height;
final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CircularProgressIndicator(
        strokeWidth: 2,
       color: color ?? kPrimaryColor, // Change color
      ),
    );
  }
}
