// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/text/text_style.dart';

class TextFieldWidget extends StatelessWidget {
  final Color color;
  final Color focusedColor;
  final String? hintText;
  final TextEditingController? textController;
  final bool obscureText;
  final FormFieldValidator<String?>? validator;

   TextFieldWidget({
    required this.color,
    required this.focusedColor,
    super.key,
    this.hintText,
    this.obscureText=false,
    this.validator,
    this.textController,
  });
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,

      child: TextFormField(
        obscureText:obscureText,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        controller: textController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: color,

            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: focusedColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),

          hintText: hintText,
          hintStyle: AppTextStyle.regular16.value.copyWith(
            color: AppColors.darkGray,
          ),
        ),
      ),
    );
  }
}
