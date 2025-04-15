import 'package:dummy/helper/common_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../helper/common_thing.dart';
import '../helper/constants.dart';
import '/Helper/Colors.dart';

class CustomTextField extends StatefulWidget {
  final bool? isAutofillEmail;
  final TextEditingController? fieldController;
  final String? hintText;
  final bool? readValue;
  final int? mxLength;
  final String? validationOf;
  final String? validationText;

  const CustomTextField({
    super.key,
    this.isAutofillEmail,
    this.fieldController,
    this.hintText,
    this.readValue,
    this.mxLength,
    this.validationOf,
    this.validationText,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isVerifiedValue = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        inputFormatters: widget.validationOf == "email"
            ? [
                FilteringTextInputFormatter.deny(RegExp(r'\s')),
                LowerCaseTextInputFormatter(),
              ]
            : [],
        cursorColor: AppColors.primary,
        cursorHeight: 17,
        style: CommonTextStyle.customTextStyle(
          fontSize: 16,
          color: AppColors.primary,
          fontWeight: FontWeight.w400,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (value) {
          setState(() {});
        },
        maxLength: widget.mxLength,
        readOnly: widget.readValue ?? false,
        controller: widget.fieldController,
        decoration: InputDecoration(
          suffixIcon: widget.validationOf == "email"
              ? widget.isAutofillEmail == true
                  ? Padding(
                      padding: const EdgeInsets.all(20),
                      child: SvgPicture.asset(
                        'assets/svg/isVerified.svg', // Path to your SVG file
                        fit: BoxFit.contain, // Optionally set BoxFit
                      ),
                    )
                  : isVerifiedValue == true
                      ? Padding(
                          padding: const EdgeInsets.all(20),
                          child: SvgPicture.asset(
                            'assets/svg/isVerified.svg', // Path to your SVG file
                            fit: BoxFit.contain, // Optionally set BoxFit
                          ),
                        )
                      : SizedBox.shrink()
              : SizedBox.shrink(),
          filled: true,
          fillColor: AppColors.primary,
          counterText: '',
          hintText: widget.hintText,
          hintStyle: CommonTextStyle.customTextStyle(
            fontSize: 16,
            color: AppColors.primary,
            fontWeight: FontWeight.w400,
          ),
          // contentPadding: const EdgeInsets.symmetric(vertical: 0),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red, width: 2)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: AppColors.primary, width: 1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red, width: 2)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.primary, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),

          errorStyle: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        validator: (value) {
          if (widget.validationOf == "empty") {
            if (value!.isEmpty) {
              return 'Please enter ${widget.validationText}';
            }
            return null; // Return null if the input is valid
          } else if (widget.validationOf == "password") {
            if (value!.isEmpty) {
              return 'Please enter ${widget.validationText}';
            }
            if (value.length < 8) {
              return 'Please enter valid ${widget.validationText}';
            }
            return null;
          } else if (widget.validationOf == "email") {
            if (value!.isEmpty) {
              isVerifiedValue = false;
              return 'Please enter ${widget.validationText}';
            }
            if (!value.contains('@')) {
              isVerifiedValue = false;
              return 'Please enter valid ${widget.validationText}';
            }
            isVerifiedValue = true;
            return null;
          }
          return null;
        });
  }
}

class LowerCaseTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Converts the new text to lowercase
    String newText = newValue.text.toLowerCase();

    // Return the new text with the necessary updates
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
