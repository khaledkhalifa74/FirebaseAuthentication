import 'package:flutter/material.dart';
import 'package:firebase_features/core/utils/assets.dart';
import 'package:firebase_features/core/utils/styles.dart';
import 'package:firebase_features/core/widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<dynamic> successFailureAlert(BuildContext context,
    {required bool isError,
    required String message,
    void Function()? onOkPresses,
    void Function()? onDismiss,
    bool? barrierDismissible}) {
  return showDialog(
    barrierDismissible: barrierDismissible ?? true,
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return AlertDialog(
          actions: [
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isError == true
                        ? Image.asset(AssetsData.failureIcon,
                            height: 56, width: 56)
                        : Image.asset(AssetsData.successIcon,
                            height: 56, width: 56),
                    const SizedBox(height: 24),
                    Text(
                      message,
                      style: Styles.textStyle14.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      height: 44,
                      text: AppLocalizations.of(context)!.ok,
                      itemCallBack: onOkPresses ??
                          () {
                            Navigator.pop(context);
                          },
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    ),
  ).then((_) {
    // This happens when dialog is dismissed by tapping outside
    if (onDismiss != null) {
      onDismiss();
    } else {
      // Safely pop if not already closed
      // if (Navigator.of(context).canPop()) {
      //   Navigator.pop(context);
      // }
    }
  });
}
