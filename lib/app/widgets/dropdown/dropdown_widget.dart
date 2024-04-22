import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import '../../core/style/app_text.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({
    super.key,
    required this.controller,
    required this.list,
    required this.hintText,
    this.onChanged,
    this.validator,
  });
  final SingleValueDropDownController controller;
  final List<DropDownValueModel> list;
  final String hintText;
  final Function(dynamic)? onChanged;
  final String? Function(String?)? validator;

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  FocusNode searchFocusNode = FocusNode();
  FocusNode textFieldFocusNode = FocusNode();
  late SingleValueDropDownController controller;

  @override
  Widget build(BuildContext context) {
    return DropDownTextField(
      validator: widget.validator,
      textStyle: AppText.text().bodyMedium,
      textFieldDecoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 17,
        ),
        filled: true,
        fillColor: AppColor.lightGrey,
        hintText: widget.hintText,
        hintStyle:
            AppText.text().bodySmall?.copyWith(color: AppColor.mediumBlue),
        enabledBorder: _buildOutlineInputBorder(),
        focusedBorder: _buildOutlineInputBorder(),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        errorStyle: const TextStyle(color: AppColor.error),
      ),
      dropDownIconProperty: IconProperty(
        icon: Icons.arrow_drop_down_rounded,
        size: 35,
        color: AppColor.mediumBlue,
      ),
      clearIconProperty: IconProperty(
        icon: Icons.close,
        size: 20,
      ),
      readOnly: true,
      controller: widget.controller,
      clearOption: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      dropDownItemCount: widget.list.length,
      dropDownList: widget.list,
      onChanged: widget.onChanged,
    );
  }

  OutlineInputBorder _buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.white),
    );
  }
}
