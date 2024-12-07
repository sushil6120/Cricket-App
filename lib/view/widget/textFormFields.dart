import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../themes/colors.dart';
import '../../utils/valueConstants.dart';

class TextFormFieldBig extends StatelessWidget {
  final double? height;
  final String? hintText;
  final Icon? prefixIcon;

  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboard;
  final bool? obscureText;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final bool? readOnly;
  final void Function()? onTap;
  final int maxLines;
  final String? labelText;
  final bool? enabled;
  final bool? isFill;
  final Color? fillColor;
  final List<TextInputFormatter>? formatters;
  final void Function(String)? onChanged;

  TextFormFieldBig({
    Key? key,
    this.height,
    required this.hintText,
    this.controller,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboard,
    this.obscureText = false,
    this.onFieldSubmitted,
    this.focusNode,
    this.readOnly = false,
    this.onTap,
    this.enabled,
    this.formatters,
    required this.maxLines,
    this.labelText,
    this.onChanged,
    
    this.isFill,
    this.fillColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        onChanged: onChanged,
        inputFormatters: formatters,
        onTap: onTap,
        readOnly: readOnly!,
        obscureText: obscureText!,
        controller: controller,
        keyboardType: keyboard,
        focusNode: focusNode,
        maxLines: maxLines,
        enabled: enabled,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: colorDark1,
              fontWeight: FontWeight.w400,
            ),
        onFieldSubmitted: onFieldSubmitted,
        validator: validator,
        cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
        decoration: InputDecoration(
      
          border: const OutlineInputBorder(),
          filled: isFill,
          fillColor: fillColor,
          isDense: true,
          labelText: labelText,
          labelStyle: TextStyle(
            color: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                )
                .color,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          errorStyle: const TextStyle(
              color: errorColor,
              fontSize: 12,
              height: 1.2), // Ensure consistent height
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: colorDark3,
              ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          errorMaxLines: 1,

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 1, color: Colors.red),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 1, color: Colors.red),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1, color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 1, color: Colors.transparent),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 1, color: Colors.transparent),
          ),
        ),
      ),
    );
  }
}
