import 'package:firebase_features/core/utils/colors.dart';
import 'package:firebase_features/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_features/core/utils/globals.dart' as globals;

class CustomTextFormFieldWithTitle extends StatefulWidget {
  final String title;
  final String? placeholder;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final bool? enabled;
  final int? maxLength;
  final bool? autoFocus;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final bool? isOptional;
  final Widget? suffix;
  final Widget? prefix;
  final bool? obscureText;
  final void Function(String)? onChanged;
  final TextStyle? titleStyle;
  final bool? readOnly;
  final FocusNode? focusNode;
  final int? minLines;
  final int? maxLines;

  const CustomTextFormFieldWithTitle({
    super.key,
    required this.title,
    this.controller,
    this.autoFocus,
    this.placeholder,
    this.inputType,
    this.enabled,
    this.maxLength,
    this.validator,
    this.isOptional,
    this.suffix,
    this.obscureText,
    this.onChanged,
    this.titleStyle,
    this.onTap,
    this.readOnly,
    this.focusNode,
    this.minLines, this.maxLines, this.prefix,
  });

  @override
  CustomTextFormFieldWithTitleState createState() => CustomTextFormFieldWithTitleState();
}

class CustomTextFormFieldWithTitleState extends State<CustomTextFormFieldWithTitle> {

  @override
  void initState() {
    super.initState();
    widget.focusNode?.addListener(() {
      if (!widget.focusNode!.hasFocus) {
        // Handle focus loss if needed
        // You can add any additional logic here
      }
    });
  }

  @override
  void dispose() {
    widget.focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isOptional != null
            ? Row(
                children: [
                  Text(
                    widget.title,
                    style: Styles.textStyle16,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    AppLocalizations.of(context)!.optional,
                    style: Styles.textStyle16.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              )
            : Text(
                widget.title,
                style: widget.titleStyle ?? Styles.textStyle16,
              ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            maxLines: widget.maxLines??1,
            minLines: widget.minLines??1,
            focusNode: widget.focusNode, // Attach the FocusNode here
            onChanged: widget.onChanged ?? (String? text){
              final converted = globals.convertArabicNumbersToEnglish(text!);
              if (text != converted) {
                final cursorPosition = widget.controller?.selection;
                widget.controller?.value = TextEditingValue(
                  text: converted,
                  selection: cursorPosition!,
                );
              }
            },
            obscureText: widget.obscureText ?? false,
            onTap: () {
              if (widget.focusNode != null) {
                if (widget.focusNode!.hasFocus) {
                  widget.focusNode?.unfocus();
                } else {
                  widget.focusNode?.requestFocus();
                }
                if (widget.onTap != null) {
                  widget.onTap!();
                }
              } else {
                if (widget.onTap != null) {
                  widget.onTap!();
                }
              }
            },
            controller: widget.controller,
            enabled: widget.enabled ?? true,
            maxLength: widget.maxLength,
            readOnly: widget.readOnly ?? false,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            keyboardType: widget.inputType,
            autofocus: widget.autoFocus ?? false,
            validator: widget.validator ??
                (data) {
                  if (data!.isEmpty) {
                    return AppLocalizations.of(context)!.cantBeEmpty;
                  } else {
                    return null;
                  }
                },
            decoration: InputDecoration(
              suffixIcon: widget.suffix,
              prefixIcon: widget.prefix != null
                  ? Padding(
                padding: EdgeInsets.only(
                    right: globals.appLang == 'en' ? 0 : 8,
                  left: globals.appLang == 'en' ? 8 : 0
                ),
                child: widget.prefix,
              )
                  : null,
              prefixIconConstraints: BoxConstraints(
                minWidth: 40,
                minHeight: 0,
              ),
              hintText: widget.placeholder,
              hintStyle: Styles.textStyle16.copyWith(
                fontWeight: FontWeight.w400,
                color: kTextFieldHintColor,
              ),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(
                    color: kFocusedBorderColor,
                    width: 1,
                    style: BorderStyle.solid,
                  )),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(
                      width: 1, color: kBorderColor, style: BorderStyle.solid)),
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(
                      width: 1, color: kBorderColor, style: BorderStyle.solid)),
              disabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(
                      width: 1,
                      color: Colors.transparent,
                      style: BorderStyle.solid)),
              errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(
                      width: 1, color: kRedColor, style: BorderStyle.solid)),
              fillColor: kWhiteColor,
              filled: true,
              contentPadding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
            ),
          ),
        ),
      ],
    );
  }
}