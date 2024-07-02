import 'package:flutter/material.dart';
import '../core/app_export.dart';

class CustomTextFormFieldLogIn extends StatelessWidget {
  CustomTextFormFieldLogIn(
      {Key? key,
      this.alignment,
      this.width,
      this.scrollPadding,
      this.controller,
      this.focusNode,
      this.autofocus = false,
      this.textStyle,
      this.obscureText = false,
      this.textInputAction = TextInputAction.next,
      this.textInputType = TextInputType.text,
      this.maxLines,
      this.hintText,
      this.hintStyle,
      this.prefix,
      this.prefixConstraints,
      this.suffix,
      this.suffixConstraints,
      this.contentPadding,
      this.validator,
      this.fieldType})
      : super(
          key: key,
        );

  final Alignment? alignment;

  final double? width;

  final TextEditingController? scrollPadding;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;

  final bool? obscureText;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;

  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final FormFieldValidator<String>? validator;

  final FieldType? fieldType; // Added fieldType parameter

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormFieldWidget(context))
        : textFormFieldWidget(context);
  }

  Widget textFormFieldWidget(BuildContext context) => SizedBox(
        width: width ?? double.maxFinite,
        child: Container(
          padding: EdgeInsets.all(16), // 16 point padding
          decoration: BoxDecoration(
            color: appTheme.blueGray600, // Background color
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
          child: TextFormField(
            scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            controller: controller,
            focusNode: focusNode,
            onTapOutside: (event) {
              if (focusNode != null) {
                focusNode?.unfocus();
              } else {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            autofocus: autofocus!,
            style: textStyle ??
                theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white), // Change text color to white
            obscureText: obscureText!,
            textInputAction: textInputAction,
            keyboardType: textInputType,
            maxLines: maxLines ?? 1,
            decoration: decoration,
            validator: validator,
          ),
        ),
      );

  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "",
        hintStyle: hintStyle ??
            theme.textTheme.bodyMedium
                ?.copyWith(color: Colors.white), // Change hint color to white
        prefixIcon: prefixIcon,
        prefixIconConstraints: BoxConstraints(
            minWidth: 0, minHeight: 0), // Adjust prefix icon constraints
        contentPadding: EdgeInsets.zero, // Remove padding
        isDense: true,
        border: InputBorder.none,
      );

  Widget get prefixIcon {
    switch (fieldType) {
      case FieldType.email:
        return Padding(
          padding: const EdgeInsets.only(
              right: 8.0), // Add padding between icon and text
          child: Icon(Icons.email, color: Colors.white),
        );
      case FieldType.name:
        return Padding(
          padding: const EdgeInsets.only(
              right: 8.0), // Add padding between icon and text
          child: Icon(Icons.person, color: Colors.white),
        );
      default:
        return suffix ?? Container(width: 0); // Use provided suffix if any
    }
  }
}

enum FieldType { email, name }
